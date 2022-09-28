from libqtile import bar, widget

from colors import colors

def get_widget_defaults():
    return { 
        'font': 'UbuntuMono Nerd Font',
        'fontsize': 14,
        'padding': 1,
    }

get_extention_defaults = get_widget_defaults

bar_size = 24
padding_from_arrow = 10 
padding_between_windget_and_icon = 6

def get_arrow():
    def construct_arrow(color):
        return widget.TextBox(font = 'sans', text = '',
            background = color['bg'], foreground = color['fg'],
            padding = 0, fontsize = 26)

    first_arrow_colors = {'bg': colors['background'], 'fg': colors['background-1']}
    last_arrow_colors = {'bg': colors['background-2'], 'fg': colors['background']}
         
    yield construct_arrow(first_arrow_colors)

    current_colors = {'bg': colors['background-1'], 'fg': colors['background-2']}
    next_colors = {'bg': colors['background-2'], 'fg': colors['background-1']}

    for _ in range(7):
        yield construct_arrow(current_colors)
        current_colors, next_colors = next_colors, current_colors

    yield construct_arrow(last_arrow_colors)


def get_bar():
    return bar.Bar(
            [
                widget.GroupBox(
                    #font = '',
                    #fontsize = '',
                    rounded = False,
                    disable_drag = True,
                    # Colors for active group
                    active = colors['active-foreground'],
                    highlight_color = colors['active-background'],
                    highlight_method = 'block',
                    # Colors for inactive groups
                    inactive = colors['inactive-foreground'],
                    # Colors for urgent groups
                    urgent_text = colors['urgent-foreground'],
                    urgent_border = colors['urgent-background'],
                    urgent_alert_method = 'block',
                    # Default colors
                    background = colors['background'],
                    foreground = colors['foreground']
                ),
                widget.Mpd2(
                    port = 6606,
                    status_format = '{play_status}  {artist} - {title} [{repeat}{random}{single}]',
                    play_states = {'pause': '', 'play': '', 'stop': ''},
                    background = colors['background'],
                    foreground = colors['foreground']
                ),
                widget.WindowName(
                    format = '',
                    background = colors['background'],
                    foreground = colors['foreground']
                ),
                widget.CurrentLayoutIcon(
                    background = colors['background'],
                    foreground = colors['foreground']
                ),
                widget.Sep(
                    background = colors['background'],
                    foreground = colors['background'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    font = 'sans',
                    text = '',
                    background = colors['background'],
                    foreground = colors['background-1'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.TextBox(
                    font = 'sans',
                    text = '',
                    fontsize = 30,
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.Wlan(
                    format = '{essid}',
                    disconnected_message = '',
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Net(
                    format = ' {down} ↓↑ {up}',
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-1'],
                    foreground = colors['background-2'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    fontsize = 24,
                    background = colors['background-2'],
                    foreground = colors['foreground-2']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.Volume(
                    background = colors['background-2'],
                    foreground = colors['foreground-2']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-2'],
                    foreground = colors['background-1'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    fontsize = 14,
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.Backlight(
                    format = '{percent:2.0%}',
                    backlight_name = 'amdgpu_bl1',
                    background = colors['background-1'],
                    foreground = colors['foreground-1'],
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-1'],
                    foreground = colors['background-2'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.Battery(
                    format = '{char}',
                    font = 'sans',
                    fontsize = 26,
                    charge_char = ' ',
                    discharge_char = ' ',
                    empty_char = '',
                    full_char = '',
                    background = colors['background-2'],
                    foreground = colors['foreground-2'],
                    low_background = colors['urgent-background'],
                    low_foreground = colors['urgent-foreground']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.Battery(
                    format = '{percent:2.0%}',
                    background = colors['background-2'],
                    foreground = colors['foreground-2'],
                    low_background = colors['urgent-background'],
                    low_foreground = colors['urgent-foreground']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-2'],
                    foreground = colors['background-1'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    fontsize = 24,
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.Memory(
                    format = '{MemUsed:.2f}{mm}',
                    measure_mem = 'G',
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-1'],
                    foreground = colors['background-2'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.DF(
                    format = '  {r:.0f}%',
                    visible_on_warn = False,
                    background = colors['background-2'],
                    foreground = colors['foreground-2']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-2'],
                    foreground = colors['background-1'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_between_windget_and_icon 
                ),
                widget.KeyboardKbdd(
                    configured_keyboards = ['us', 'ru'],
                    background = colors['background-1'],
                    foreground = colors['foreground-1']
                ),
                widget.Sep(
                    background = colors['background-1'],
                    foreground = colors['background-1'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-1'],
                    foreground = colors['background-2'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.Clock(
                    #format='%Y-%m-%d %H:%M:%S',
                    format='%H:%M:%S',
                    background = colors['background-2'],
                    foreground = colors['foreground-2']
                ),
                widget.Sep(
                    background = colors['background-2'],
                    foreground = colors['background-2'],
                    padding = padding_from_arrow
                ),
                widget.TextBox(
                    text = '',
                    font = 'sans',
                    background = colors['background-2'],
                    foreground = colors['background'],
                    padding = 0,
                    fontsize = 26,
                ),
                widget.Systray(
                    background = colors['background'],
                ),
                widget.Sep(
                    background = colors['background'],
                    foreground = colors['background'],
                    padding = 4
                )
            ],
            bar_size,
        )
