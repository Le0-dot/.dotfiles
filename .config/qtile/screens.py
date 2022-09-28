from libqtile.config import Screen

from bar import main_bar, secondary_bar

screens = [
    Screen(top = main_bar),
    Screen(top = secondary_bar), 
]
