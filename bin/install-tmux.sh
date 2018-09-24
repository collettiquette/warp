#!/bin/bash -ex

install_tmux() {
  local os="$1"

  if [[ $os == "MacOS" ]]; then
    brew install tmux
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" ]]; then
    sudo apt-get install tmux
  fi

  if [[ $os == "rhel" ]]; then
    sudo yum install tmux
  fi
}

main() {
  local os="$1"
  if tmux -V; then
    echo "Tmux already installed."
  else
    install_tmux $os
  fi
}

main "$@"
