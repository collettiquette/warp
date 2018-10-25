#!/bin/bash -ex

install_htop() {
  local os="$1"

  if [[ $os == "MacOS" ]]; then
    brew install htop
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" ]]; then
    sudo apt-get -y install htop
  fi

  if [[ $os == "rhel" ]]; then
    sudo yum -y install htop
  fi
}

main() {
	local os="$1"
  echo "Htop: Checking installation..."
  if which htop; then
    echo "Htop: Already installed!"
  else
    echo "Htop: Installing..."
    install_htop $os
    echo "Htop: Installed!"
  fi
}

main "$@"
