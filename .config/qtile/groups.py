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


class Groups:
    @staticmethod
    def makeMatches(l):
        return [Match(wm_class=[window]) for window in l]

    @staticmethod
    def dictToGroup(d):
        return Group(d['name'], layout=d['layout'], matches=Groups.makeMatches(d['matches']))

    def __init__(self, group_config):
        self._group_generator = (x for x in group_config)
        self._current_group_repr = None

    def __iter__(self):
        self._current_group_repr = next(self._group_generator)
        return self

    def __next__(self):
        if self._current_group_repr is None:
            raise StopIteration
        group = Groups.dictToGroup(self._current_group_repr)
        self._current_group_repr = next(self._group_generator, None)
        return group


groups = list(Groups(group_config))

group_names = [group['name'] for group in group_config]
