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
    echo "Warp: Error: Unsupported OS. Cancelling Install."
    exit 1
  fi
}

setup() {
  local os="$1"

  # Make directories for sandbox environment
  mkdir -p ~/.warp/bin
  mkdir -p ~/.warp/config
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/warp.ascii --output ~/.warp/config/warp.ascii
  cat ~/.warp/config/warp.ascii

  # Run install scripts
  echo "Warp: Checking dependencies..."
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-tmux.sh | bash -s $os
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-neovim.sh | bash -s $os
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/install-plug.sh | bash -s $os

  # Download config files
  echo "Warp: Downloading configuration..."
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/vimrc --output ~/.warp/config/vimrc
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/tmux.conf --output ~/.warp/config/tmux.conf

  # Run setup scripts
  echo "Warp: Downloading setup utilities..."
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/tmux-session.sh --output ~/.warp/bin/tmux-session.sh
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/aliases.sh --output ~/.warp/bin/aliases.sh

  echo "Warp: Make setup utility scripts executable..."
  chmod +x ~/.warp/bin/tmux-session.sh
  chmod +x ~/.warp/bin/aliases.sh

  echo "Warp: Alias utilities..."
  source  ~/.warp/bin/aliases.sh
}

main() {
  local os=$(host_os)
  is_valid_os $os
  setup $os
}

main "$@"
