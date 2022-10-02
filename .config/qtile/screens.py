from bar import main_bar, secondary_bar
from libqtile.config import Screen

screens = [
    Screen(top = main_bar),
    Screen(top = secondary_bar), 
]
