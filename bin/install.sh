#!/bin/bash -ex

hostos=$(uname -s)

host_os() {
  if [[ $hostos == "Darwin" ]]; then
    echo "MacOS"
  else
    echo $(cat /etc/*release | sed -n 5p | grep -oP '(?<==).*' | awk '{ print $1 }' | tr -d '"')
  fi
  return 0
}

is_valid_os() {
  local os="$1"

  if [[ $os == "MacOS" || $os == "Ubuntu" || $os == "Debian" || $os == "rhel" ]]; then
    return 0
  else
    echo "Error: Unsupported OS. Cancelling Install."
    exit 1
  fi
}

setup() {
  local os="$1"

  # Make directories for sandbox environment
  mkdir -p ~/.warp/bin
  mkdir -p ~/.warp/config

  # Run install scripts
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-tmux.sh | bash $os
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-htop.sh | bash $os
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-neovim.sh | bash $os
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-plug.sh | bash $os

  # Download config files
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/vimrc --output ~/.warp/config/vimrc
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/tmux.conf --output ~/.warp/config/tmux.conf

  # Run setup scripts
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/tmux-session.sh | bash $os
  curl -sL https://raw.githubusercontent.com/collettiquette/warp/master/bin/aliases.sh | source
}

main() {
  local os=$(host_os)
  is_valid_os $os
  setup $os
}

main "$@"
