# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile.dgroups import simple_key_binder

mod = "mod4"
terminal = guess_terminal()

commands = {
    'volume_up': 'amixer -q -D pulse sset Master 5%+',
    'volume_down': 'amixer -q -D pulse sset Master 5%-',
    'brightness_up': 'sudo light -A 5',
    'brightness_down': 'sudo light -U 5',
    'music_toggle': 'mpc --host=127.0.0.1 --port=6606 toggle',
    'music_prev': 'mpc --host=127.0.0.1 --port=6606 prev',
    'music_next': 'mpc --host=127.0.0.1 --port=6606 next',
    'music_volume_up': 'mpc --host=127.0.0.1 --port=6606 volume +2',
    'music_volume_down': 'mpc --host=127.0.0.1 --port=6606 volume -2',
    'music_random_toggle': 'mpc --host=127.0.0.1 --port=6606 random',
    'rofi': 'rofi -show drun',
    'firefox': 'firefox',
    'firefox-private': 'firefox --private-window',
    'telegram': 'telegram-desktop',
    'discord': 'discord',
    'exit_menu': './.local/bin/exit_menu',
    'lock': './.local/bin/lock'
}

group_names = (
        '1: ',
        '2: ',
        '3: ',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10: '
)

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    #Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
    #    desc="Toggle between split and unsplit sides of stack"),
    
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    # Volume and brightness control
    Key([], 'XF86AudioRaiseVolume', lazy.spawn(commands['volume_up']),
        desc='Volume up'),
    Key([], 'XF86AudioLowerVolume', lazy.spawn(commands['volume_down']),
        desc='Volume down'),

    Key([], 'XF86MonBrightnessUp', lazy.spawn(commands['brightness_up']),
        desc='Brightness up'),
    Key([], 'XF86MonBrightnessDown', lazy.spawn(commands['brightness_down']),
        desc='Brightness down'),

    # MPD control
    Key([mod, 'mod1'], 'j', lazy.spawn(commands['music_toggle']),
        desc='Toggle music'),
    Key([mod, 'mod1'], 'h', lazy.spawn(commands['music_prev']),
        desc='Next track'),
    Key([mod, 'mod1'], 'k', lazy.spawn(commands['music_next']),
        desc='Previous track'),
    Key([mod, 'mod1'], 'u', lazy.spawn(commands['music_volume_up']),
        desc='Music volume up'),
    Key([mod, 'mod1'], 'm', lazy.spawn(commands['music_volume_down']),
        desc='Music volume down'),
    Key([mod, 'mod1'], 'r', lazy.spawn(commands['music_random_toggle']),
        desc='Toggle random track'),

    # Launch programs
    Key([mod, 'shift'], 'Return', lazy.spawn(commands['rofi']),
            desc='Launch rofi'),
    Key([mod], 'Escape', lazy.spawn(commands['exit_menu']),
            desc='Launch exit_menu script'),
    Key([mod, 'shift'], 'x', lazy.spawn(commands['lock']),
            desc='Launch locker script'),

    Key([mod], 'f', lazy.spawn(commands['firefox']),
            lazy.group[group_names[1]].toscreen(toggle=False),
            desc='Launch firefox'),
    Key([mod], 'p', lazy.spawn(commands['firefox-private']),
            lazy.group[group_names[1]].toscreen(toggle=False),
            desc='Launch firefox private window'),
    Key([mod], 't', lazy.spawn(commands['telegram']),
            lazy.group[group_names[2]].toscreen(toggle=False),
            desc='Launch telegram'),
    Key([mod], 'd', lazy.spawn(commands['discord']),
            lazy.group[group_names[2]].toscreen(toggle=False),
            desc='Launch discord')
]

groups = [Group(group_names[0], layout='columns',
              matches=[Match(wm_class=["alacritty"])]),
          Group(group_names[1], layout='max', 
              matches=[Match(wm_class=["firefox"])]),
          Group(group_names[2], layout='max', 
              matches=[Match(wm_class=["TelegramDesktop"]),
                       Match(wm_class=["discord"])]),
          Group(group_names[3]),
          Group(group_names[4]),
          Group(group_names[5]),
          Group(group_names[6]),
          Group(group_names[7]),
          Group(group_names[8]),
          Group(group_names[9], layout='max',
              matches=[Match(wm_class=["vlc"])])]


layouts = [
    layout.Columns(border_focus_stack=['#d75f5f', '#8f3d3d'], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        'launch': ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.TextBox("default config", name="default"),
                widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.Systray(),
                widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                widget.QuickExit(),
            ],
            24,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = simple_key_binder(mod)
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
wmname = 'qtile'
