from libqtile import layout

from colors import colors

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

def get_layouts():
    return layouts
