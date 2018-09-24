#!/bin/bash -ex

main() {
  alias tmux=~/.warp/bin/tmux-session.sh
  alias vim=~/.warp/bin/nvim
}

main "$@"
