from colors import colors
from keybindings import mod
from libqtile import layout
from libqtile.config import Click, Drag
from libqtile.lazy import lazy

layouts = [
    layout.Columns(
        border_focus = colors['background-2'],
        border_normal = colors['background'],
        border_width = 1
    ),
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

mouse = [
    Drag([mod], 'Button1', lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Click([mod], 'Button1', lazy.window.toggle_floating()),
    Drag([mod], 'Button3', lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], 'Button2', lazy.window.bring_to_front())
]
