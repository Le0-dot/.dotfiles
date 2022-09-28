from libqtile import bar, widget

from colors import colors

widget_defaults = { 
    'font': 'UbuntuMono Nerd Font',
    'fontsize': 14,
    'padding': 1,
}

extention_defaults = widget_defaults.copy()

bar_size = 24
padding_from_arrow = 10 
padding_between_windget_and_icon = 6
padding_from_border = 4

left_side = lambda: [
    widget.GroupBox(
        rounded = False,
        disable_drag = True,
        active = colors['active-foreground'],
        highlight_color = colors['active-background'],
        highlight_method = 'block',
        inactive = colors['inactive-foreground'],
        urgent_text = colors['urgent-foreground'],
        urgent_border = colors['urgent-background'],
        urgent_alert_method = 'block',
    ),
    widget.Mpd2(
        port = 6606,
        status_format = '{play_status}  {artist} - {title} [{repeat}{random}{single}]',
        play_states = {'pause': '', 'play': '', 'stop': ''},
    ),
    widget.WindowName(format = ''),
    widget.CurrentLayoutIcon(),
    widget.Sep(padding = padding_from_arrow)
]

inet = lambda: [
    widget.TextBox(
        font = 'sans',
        text = '',
        fontsize = 30,
    ),
    widget.Sep(padding = padding_between_windget_and_icon),
    widget.Wlan(
        format = '{essid}',
        disconnected_message = '',
    ),
    widget.Net(format = ' {down} ↓↑ {up}'),
    widget.Sep(padding = padding_from_arrow)
]

volume = lambda: [
    widget.TextBox(
        text = '',
        font = 'sans',
        fontsize = 24,
    ),
    widget.Sep(padding = padding_between_windget_and_icon ),
    widget.Volume(),
    widget.Sep(padding = padding_from_arrow)
]

brightness = lambda: [
    widget.TextBox(
        text = '',
        font = 'sans',
        fontsize = 14,
    ),
    widget.Sep(padding = padding_between_windget_and_icon),
    widget.Backlight(
        format = '{percent:2.0%}',
        backlight_name = 'amdgpu_bl1',
    ),
    widget.Sep(padding = padding_from_arrow)
]

battery = lambda: [
    widget.Battery(
        format = '{char}',
        font = 'sans',
        fontsize = 26,
        charge_char = ' ',
        discharge_char = ' ',
        empty_char = '',
        full_char = '',
        low_background = colors['urgent-background'],
        low_foreground = colors['urgent-foreground']
    ),
    widget.Sep(padding = padding_between_windget_and_icon ),
    widget.Battery(
        format = '{percent:2.0%}',
        low_background = colors['urgent-background'],
        low_foreground = colors['urgent-foreground']
    ),
    widget.Sep(padding = padding_from_arrow)
]

ram = lambda: [
    widget.TextBox(
        text = '',
        font = 'sans',
        fontsize = 24,
    ),
    widget.Sep(padding = padding_between_windget_and_icon ),
    widget.Memory(
        format = '{MemUsed:.2f}{mm}',
        measure_mem = 'G',
    ),
    widget.Sep(padding = padding_from_arrow)
]

mem = lambda: [
    widget.DF(
        format = '  {r:.0f}%',
        visible_on_warn = False,
    ),
    widget.Sep(padding = padding_from_arrow)
]

kbd = lambda: [
    widget.TextBox(
        text = '',
        font = 'sans',
    ),
    widget.Sep(padding = padding_between_windget_and_icon ),
    widget.KeyboardKbdd(configured_keyboards = ['us', 'ru']),
    widget.Sep(padding = padding_from_arrow)        
]

time = lambda: [
    widget.Clock(format='%H:%M:%S'), #format='%Y-%m-%d %H:%M:%S'
    widget.Sep(padding = padding_from_arrow),
]

tray = lambda: [
    widget.Systray(),
    widget.Sep(padding = padding_from_border)
]


main_widget_groups = [
        left_side(),
        inet(),
        volume(),
        brightness(),
        battery(),
        ram(),
        mem(),
        kbd(),
        time(),
        tray()
]

secondary_widget_groups = [
        left_side(),
        inet(),
        volume(),
        brightness(),
        battery(),
        ram(),
        mem(),
        kbd(),
        time(),
]

def get_widgets(widget_groups):
    def get_colors():
        yield {'bg': colors['background'], 'fg': colors['foreground']}

        current_colors = {'bg': colors['background-1'], 'fg': colors['foreground-1']}
        next_colors = {'bg': colors['background-2'], 'fg': colors['foreground-2']}

        for _ in range(len(widget_groups) - 2):
            print(current_colors)
            yield current_colors
            current_colors, next_colors = next_colors, current_colors

        yield {'bg': colors['background'], 'fg': colors['foreground']}

    color = get_colors()

    for g in widget_groups:
        current_colors = next(color)
        for w in g:
            w.background = current_colors['bg']
            w.foreground = current_colors['fg'] if not isinstance(w, widget.Sep) else current_colors['bg']
        yield g


def get_arrows(num):
    def construct_arrow(color):
        return widget.TextBox(font = 'sans', text = '',
            background = color['bg'], foreground = color['fg'],
            padding = 0, fontsize = 26)

    def get_colors():
        yield {'bg': colors['background'], 'fg': colors['background-1']}

        current_colors = {'bg': colors['background-1'], 'fg': colors['background-2']}
        next_colors = {'bg': colors['background-2'], 'fg': colors['background-1']}

        for _ in range(num - 2):
            yield current_colors
            current_colors, next_colors = next_colors, current_colors

        yield {'bg': current_colors['bg'], 'fg': colors['background']}

    for color in get_colors():
        yield construct_arrow(color)


def get_bar(widget_groups):
    widget_group = get_widgets(widget_groups)
    widget_list = next(widget_group)
    for arrow in get_arrows(len(widget_groups) - 1):
        widget_list.append(arrow)
        widget_list += next(widget_group)

    return bar.Bar(widget_list, bar_size)

main_bar = get_bar(main_widget_groups)
secondary_bar = get_bar(secondary_widget_groups)
