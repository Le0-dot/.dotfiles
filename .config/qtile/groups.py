from dataclasses import dataclass, field

from libqtile.config import Group, Match


@dataclass
class group:
    name: str
    layout: str = 'max'
    matches: list[str] = field(default_factory=list)

    def convert_matches(self):
        return [Match(wm_class=window) for window in self.matches]

    def toGroup(self):
        return Group(self.name, layout = self.layout, matches = self.convert_matches())


group_config = (
    group('1:  ', layout = 'columns', matches = ['alacritty']),
    group('2:  ', matches = ['firefox']),
    group('3:  ', matches = ['TelegramDesktop', 'discord', 'microsoft teams - preview', 'Viber']),
    group('4:  ', matches = ['mupdf']),
    group('5:  ', matches = ['filezilla']),
    group('6', matches = []),
    group('7', matches = []),
    group('8', matches = []),
    group('9:  ', matches = ['Thunderbird']),
    group('10:  ', matches = ['vlc', 'spotify'])
)


class Groups:
    def __init__(self, group_config):
        self._group_generator = (x for x in group_config)

    def __iter__(self):
        return self

    def __next__(self):
        group = next(self._group_generator, None)
        if group is None:
            raise StopIteration
        return group.toGroup()

groups = list(Groups(group_config))

group_names = [group.name for group in group_config]
