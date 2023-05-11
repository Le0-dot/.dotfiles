from libqtile.lazy import lazy
from libqtile import bar, widget

from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

from colors import colors

widget_defaults = {
    'font': 'UbuntuMono Nerd Font',
    'fontsize': 14,
    'padding': 1,
}

extention_defaults = widget_defaults.copy()

BAR_SIZE = 24
PADDING_LEFT = 6
PADDING_RIGHT = 8
PADDING_FROM_BORDER = 4
PADDING_GROUP_BOX = 4

powerline = {
    'decorations': [
        PowerLineDecoration(path="arrow_right", size=12)
    ]
}

def get_resourse_callback():
    ''' Get callback for ram widget '''
    return lazy.spawn('alacritty -e htop')

def get_storage_callback():
    ''' Get callback for disk widget '''
    return lazy.spawn('alacritty -e sudo storage_stats')

def get_time_callback():
    ''' Get callback for time widget '''
    return lazy.spawn('firefox https://time.is')


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
    ]

def inet():
    return [
        widget.Net(
            format = '{down} ↓↑ {up}',
        ),
    ]

def volume():
    return [
        widget.Volume(
            fmt = '  {}',
            step = 5
        ),
    ]

def brightness():
    return [
        widget.Backlight(
            format = ' {percent:2.0%}',
            font = 'hack',
            fontsize = 14,
            backlight_name = 'amdgpu_bl1',
        ),
    ]

def battery():
    return [
        widget.Battery(
            format = '{char} {percent:2.0%}',
            charge_char = '   ',
            discharge_char = '   ',
            empty_char = '  ',
            full_char = '  ',
            show_short_text = False,
            low_background = colors['urgent-background'],
            low_foreground = colors['urgent-foreground']
        ),
    ]

def ram():
    return [
        widget.Memory(
            format = '  {MemUsed:.2f}{mm}',
            measure_mem = 'G',
            mouse_callbacks = {'Button1': get_resourse_callback()},
        ),
    ]

def mem():
    return [
        widget.DF(
            format = '  {r:.0f}%',
            visible_on_warn = False,
            mouse_callbacks = {'Button1': get_storage_callback()},
        ),
    ]

def kbd():
    return [
        widget.KeyboardKbdd(
            configured_keyboards = ['EN', 'RU'],
            fmt = '  {}'
        ),
    ]

def time():
    return [
        widget.Clock(
            format='%H:%M:%S',
            mouse_callbacks = {'Button1': get_time_callback()},
        ),
    ]

def tray():
    return [widget.Systray()]

def empty():
    return []

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

def get_widget_groups(widget_groups_functions):
    return [f() for f in widget_groups_functions]

def add_separators(widget_groups):
    sep_group_box = lambda: [widget.Sep(padding = PADDING_GROUP_BOX, linewidth = 0)]
    sep_left = lambda: [widget.Sep(padding = PADDING_LEFT, linewidth = 0)]
    sep_right = lambda: [widget.Sep(padding = PADDING_RIGHT, linewidth = 0, **powerline,)]
    sep_border = lambda: [widget.Sep(padding = PADDING_FROM_BORDER, linewidth = 0)]

    result = []
    for widget_group in widget_groups:
        left = sep_left()
        right = sep_right()

        match widget_group:
            case []:
                left = []
                right = sep_border()
            case [widget.Systray()]:
                right = sep_border()
            case [widget.GroupBox(), widget.Mpd2(), widget.WindowName(), widget.CurrentLayoutIcon()]:
                left = []
                widget_group = widget_group[:1] + sep_group_box() + widget_group[1:]
        result.append(left + widget_group + right)

    return result

def add_colors(widget_groups):
    def add_color(wg, color):
        for w in wg:
            w.background = color[0]
            w.foreground = color[1]
        return wg

    FIRST_COLOR = colors['background'], colors['foreground']
    REPEATING_COLORS = (
        colors['background-1'], colors['foreground-1']
    ), (
        colors['background-2'], colors['foreground-2']
    )
    LAST_COLOR = colors['background'], colors['foreground']


    result = [add_color(widget_groups[0], FIRST_COLOR)]

    cur_color, next_color = REPEATING_COLORS
    for wg in widget_groups[1:-1]:
        result.append(add_color(wg, cur_color))
        cur_color, next_color = next_color, cur_color

    result.append(add_color(widget_groups[-1], LAST_COLOR))

    return result

def get_widgets(widget_groups):
    widget_groups = get_widget_groups(widget_groups)
    widget_groups = add_separators(widget_groups)
    widget_groups = add_colors(widget_groups)
    return [w for wg in widget_groups for w in wg]

def get_bar(widget_groups):
    widgets = get_widgets(widget_groups)
    return bar.Bar(widgets, BAR_SIZE)

main_bar = get_bar(main_widget_groups)
secondary_bar = get_bar(secondary_widget_groups)
