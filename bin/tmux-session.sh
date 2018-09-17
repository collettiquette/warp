#!/bin/sh -ex
main() {
  tmux new-session \; \
    split-window -v -p 25 \; \
    split-window -h -p 50 \; \
    select-pane -t 0 \; \
    rename-window 'primary' \; \
    new-window \; \
    rename-window 'secondary' \; \
    new-window \; \
    rename-window 'tertiary' \; \
    select-window -t 0 \;
}

main "$@"

