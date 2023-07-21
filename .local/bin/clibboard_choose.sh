#!/bin/bash


# I need to replace tabs with spaces, since my tofi setup unable to display them

cliphist list | sed 's/\t/    /' | tofi | cut -d' ' -f1 | xargs printf "%d\t" | cliphist decode | wl-copy
