#!/bin/sh -ex

main() {
  tmux new-session \; \
    split-window -v -p 25 \; \
    select-pane -t 0 \; \
    rename-window 'primary' \; \
    new-window \; \
    rename-window 'secondary' \; \
    new-window \; \
    rename-window 'htop' \; \
    send-keys 'htop' C-m \; \
    select-window -t 0 \;
}

main "$@"
