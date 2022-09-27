from libqtile.config import Group, Match

group_config = (
    {'name': '1:  ', 'layout': 'columns', 'matches': ['alacritty']},
    {'name': '2:  ', 'layout': 'max', 'matches': ['firefox']},
    {'name': '3:  ', 'layout': 'max', 'matches': ['TelegramDesktop', 'discord', 'microsoft teams - preview', 'viber']},
    {'name': '4:  ', 'layout': 'max', 'matches': ['mupdf']},
    {'name': '5:  ', 'layout': 'max', 'matches': ['filezilla']},
    {'name': '6', 'layout': 'max', 'matches': ['']},
    {'name': '7', 'layout': 'max', 'matches': ['']},
    {'name': '8', 'layout': 'max', 'matches': ['']},
    {'name': '9:  ', 'layout': 'max', 'matches': ['Thunderbird']},
    {'name': '10:  ', 'layout': 'max', 'matches': ['vlc']}
)

def makeMatches(l):
    return [Match(wm_class=[window]) for window in l]

def dictToGroup(d):
    return Group(d['name'], layout=d['layout'], matches=makeMatches(d['matches']))

class Groups:
    def __init__(self, group_config):
        self._group_generator = (x for x in group_config)
        self._current_group_repr = None

    def __iter__(self):
        self._current_group_repr = next(self._group_generator)
        return self

    def __next__(self):
        if self._current_group_repr is None:
            raise StopIteration
        group = dictToGroup(self._current_group_repr)
        self._current_group_repr = next(self._group_generator, None)
        return group


def get_groups():
    return list(Groups(group_config))

def get_group_names():
    return [group['name'] for group in group_config]
