from dataclasses import dataclass, field
from typing import Optional

from groups import group_names
from libqtile.config import Key
from libqtile.lazy import LazyCall, lazy


@dataclass
class Keybinding:
    'Proxy class to easily create keybindings'
    name: str
    mods: list[str]
    key: str
    spawn: str = ''
    to_group: int = -1
    action: Optional[LazyCall] = None
    __all_actions: list[LazyCall] = field(repr = False, default_factory = list)

    def evaluate_actions(self, groups: list[str]):
        'Evaluate actions, such as applications, spawning group, and more'
        if self.spawn:
            self.__all_actions.append(lazy.spawn(self.spawn))
        if 0 <= self.to_group <= 9:
            self.__all_actions.append(lazy.group[groups[self.to_group]].toscreen(toggle=False))
        if not self.action is None:
            self.__all_actions.append(self.action)
        return self

    def to_key(self):
        'Construct a qtile Key class from caller'
        return Key(self.mods, self.key, *self.__all_actions, desc=self.name)



mod: str = 'mod4'
alt: str = 'mod1'
shift: str = 'shift'
control: str = 'control'
terminal: str = 'alacritty' #guess_terminal()

keybindings_config = [
    # General keybindings
    Keybinding('toggle_layout', [mod], 'Tab', action=lazy.next_layout()),
    Keybinding('kill_window', [mod], 'w', action=lazy.window.kill()),
    Keybinding('restart_qtile', [mod, control], 'r', action=lazy.restart()),
    Keybinding('kill_qtile', [mod, control], 'q', action=lazy.shutdown()),

    # Move between windows
    Keybinding('focus_left', [mod], 'h', action=lazy.layout.left()),
    Keybinding('focus_right', [mod], 'l', action=lazy.layout.right()),
    Keybinding('focus_up', [mod], 'k', action=lazy.layout.up()),
    Keybinding('focus_down', [mod], 'j', action=lazy.layout.down()),
    Keybinding('toggle_split', [mod], 'space', action=lazy.layout.toggle_split()),

    # Move windows
    Keybinding('move_window_left', [mod, shift], 'h', action=lazy.layout.shuffle_left()),
    Keybinding('move_window_right', [mod, shift], 'l', action=lazy.layout.shuffle_right()),
    Keybinding('move_window_up', [mod, shift], 'k', action=lazy.layout.shuffle_up()),
    Keybinding('move_window_down', [mod, shift], 'j', action=lazy.layout.shuffle_down()),

    # Windown size manipulation
    Keybinding('grow_window_left', [mod, control], 'h', action=lazy.layout.grow_left()),
    Keybinding('grow_window_right', [mod, control], 'l', action=lazy.layout.grow_right()),
    Keybinding('grow_window_up', [mod, control], 'k', action=lazy.layout.grow_up()),
    Keybinding('grow_window_down', [mod, control], 'j', action=lazy.layout.grow_down()),
    Keybinding('normalize_window', [mod], 'n', action=lazy.layout.normalize_window()),

    # Screen switch
    Keybinding('switch_screen_1', [mod, alt], '1', action=lazy.to_screen(0)),
    Keybinding('switch_screen_2', [mod, alt], '2', action=lazy.to_screen(1)),
    Keybinding('switch_screen_3', [mod, alt], '3', action=lazy.to_screen(2)),

    # Volume control
    Keybinding('volume_mute', [], 'F1', spawn='amixer -q -D pulse sset Master toggle'),
    Keybinding('volume_up', [], 'F3', spawn='amixer -q -D pulse sset Master 5%+'),
    Keybinding('volume_down', [], 'F2', spawn='amixer -q -D pulse sset Master 5%-'),

    # Brightness control
    Keybinding('brightness_up', [], 'F8', spawn='sudo light -A 5'),
    Keybinding('brightness_down', [], 'F7', spawn='sudo light -U 5'),

    # Mpd control
    Keybinding('music_toggle', [mod, alt], 'space',
               spawn='mpc --host=127.0.0.1 --port=6606 toggle'),
    Keybinding('music_prev', [mod, alt], 'h',
               spawn='mpc --host=127.0.0.1 --port=6606 prev'),
    Keybinding('music_next', [mod, alt], 'l',
               spawn='mpc --host=127.0.0.1 --port=6606 next'),
    Keybinding('music_volume_up', [mod, alt], 'k',
               spawn='mpc --host=127.0.0.1 --port=6606 volume +2'),
    Keybinding('music_volume_down', [mod, alt], 'j',
               spawn='mpc --host=127.0.0.1 --port=6606 volume -2'),
    Keybinding('music_random_toggle', [mod, alt], 'r',
               spawn='mpc --host=127.0.0.1 --port=6606 random'),

    # Program launchers
    Keybinding('terminal', [mod], 'Return', spawn=terminal),
    Keybinding('rofi', [mod, shift], 'Return',
               spawn='rofi -show drun -theme ~/.config/rofi/themes/center.rasi'),
    Keybinding('firefox', [mod], 'f', spawn='firefox', to_group=1),
    Keybinding('firefox-private', [mod], 'p', spawn='firefox --private-window', to_group=1),
    Keybinding('telegram', [mod], 't', spawn='telegram-desktop', to_group=2),
    Keybinding('ms_teams', [mod, shift], 't',
               spawn='teams --disable-seccomp-filter-sandbox', to_group=2),
    Keybinding('discord', [mod], 'd', spawn='discord', to_group=2),
    Keybinding('exit_menu', [mod], 'Escape', spawn='./.local/bin/exit_menu'),
    Keybinding('lock', [mod, shift], 'x', spawn='./.local/bin/lock'),
    Keybinding('filezilla', [mod, control], 'f', spawn='filezilla', to_group=3),
    Keybinding('thunderbird', [mod, control], 't', spawn='thunderbird', to_group=8)
]


keys = [keybinding.evaluate_actions(group_names).to_key() for keybinding in keybindings_config]