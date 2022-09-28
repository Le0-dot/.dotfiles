from libqtile.config import Screen

from bar import get_bar

screens = [
    Screen(top = get_bar()),
#    Screen(top = get_bar()), 
#    Screen(top = get_bar())
]
