#!/usr/bin/env zsh
# vim: set et ft=zsh sw=4 ts=8 sts=4
for f in $@ ; do
    mkdir -p `dirname "$f"` && touch "$f"
done
