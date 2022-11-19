from libqtile.lazy import lazy
from libqtile import bar, widget

from colors import colors

widget_defaults = {
    'font': 'UbuntuMono Nerd Font',
    'fontsize': 14,
    'padding': 1,
}

extention_defaults = widget_defaults.copy()

BAR_SIZE = 24
PADDING_FROM_ARROW = 10 
PADDING_BETWEEN_WIDGET_AND_ICON = 6
PADDING_FROM_BORDER = 4

def get_network_callback():
    ''' Get callback for network widget '''
    return lazy.spawn('alacritty -e sudo iwctl')

def get_resourse_callback():
    ''' Get callback for ram widget '''
    return lazy.spawn('alacritty -e htop')

def get_storage_callback():
    ''' Get callback for disk widget '''
    return lazy.spawn('alacritty -e sudo storage_stats')


def wm_groups():
    return [
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
        )
    ]

def mpd():
    return [
        widget.Mpd2(
            port = 6606,
            status_format = '{play_status}  {artist} - {title} [{repeat}{random}{single}]',
            play_states = {'pause': '', 'play': '', 'stop': ''},
        )
    ]

def middle_separator():
    return [
        widget.WindowName(format = '')
    ]

def layout():
    return [
        widget.CurrentLayoutIcon(),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def inet():
    return [
        widget.TextBox(
            font = 'sans',
            text = '',
            fontsize = 30,
            mouse_callbacks = {'Button1': get_network_callback()},
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON),
        widget.Wlan(
            format = '{essid}',
            disconnected_message = '',
            mouse_callbacks = {'Button1': get_network_callback()},
        ),
        widget.Net(
            format = ' {down} ↓↑ {up}',
            mouse_callbacks = {'Button1': get_network_callback()},
        ),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def volume():
    return [
        widget.TextBox(
            text = '',
            font = 'sans',
            fontsize = 24,
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON ),
        widget.Volume(),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def brightness():
    return [
        widget.TextBox(
            text = '',
            font = 'sans',
            fontsize = 14,
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON),
        widget.Backlight(
            format = '{percent:2.0%}',
            backlight_name = 'amdgpu_bl1',
        ),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def battery():
    return [
        widget.Battery(
            format = '{char}',
            font = 'sans',
            fontsize = 26,
            charge_char = ' ',
            discharge_char = ' ',
            empty_char = '',
            full_char = '',
            show_short_text = False,
            low_background = colors['urgent-background'],
            low_foreground = colors['urgent-foreground']
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON),
        widget.Battery(
            format = '{percent:2.0%}',
            show_short_text = False,
            low_background = colors['urgent-background'],
            low_foreground = colors['urgent-foreground']
        ),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def ram():
    return [
        widget.TextBox(
            text = '',
            font = 'sans',
            fontsize = 24,
            mouse_callbacks = {'Button1': get_resourse_callback()},
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON ),
        widget.Memory(
            format = '{MemUsed:.2f}{mm}',
            measure_mem = 'G',
            mouse_callbacks = {'Button1': get_resourse_callback()},
        ),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def mem():
    return [
        widget.DF(
            format = '  {r:.0f}%',
            visible_on_warn = False,
            mouse_callbacks = {'Button1': get_storage_callback()},
        ),
        widget.Sep(padding = PADDING_FROM_ARROW)
    ]

def kbd():
    return [
        widget.TextBox(
            text = '',
            font = 'sans',
        ),
        widget.Sep(padding = PADDING_BETWEEN_WIDGET_AND_ICON ),
        widget.KeyboardKbdd(configured_keyboards = ['US', 'RU']),
        widget.Sep(padding = PADDING_FROM_ARROW)        
    ]

def time():
    return [
        widget.Clock(format='%H:%M:%S'), #format='%Y-%m-%d %H:%M:%S'
        widget.Sep(padding = PADDING_FROM_ARROW),
    ]

def tray():
    return [
        widget.Systray(),
        widget.Sep(padding = PADDING_FROM_BORDER)
    ]

def empty():
    return [
        widget.Sep(padding = PADDING_FROM_BORDER)
    ]

def mandatory():
    return [*wm_groups(), *mpd(), *middle_separator(), *layout()]

main_widget_groups = [
        mandatory,
        inet,
        volume,
        brightness,
        battery,
        ram,
        mem,
        kbd,
        time,
        tray
]

secondary_widget_groups = [
        mandatory,
        inet,
        volume,
        brightness,
        battery,
        ram,
        mem,
        kbd,
        time,
        empty
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

    for widget_group in widget_groups:
        current_colors = next(color)
        group = widget_group()
        for w in group:
            w.background = current_colors['bg']
            w.foreground = current_colors['fg'] if not isinstance(w, widget.Sep) else current_colors['bg']
        yield group


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

    return bar.Bar(widget_list, BAR_SIZE)

main_bar = get_bar(main_widget_groups)
secondary_bar = get_bar(secondary_widget_groups)
