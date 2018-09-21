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

install_tmux() {
  local os="$1"

  if tmux -V; then
    echo "tmux installed!"
    return 0
  else
    echo "tmux not installed"
    echo "installing tmux..."
    install_tmux_os $os
  fi
}

install_tmux_os() {
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

  return 0
}

install_neovim() {
  local os="$1"

  if nvim -v; then
    echo "neovim installed!"
    return 0
  else
    echo "neovim not installed"
    echo "installing neovim..."
    install_neovim_os $os
  fi
}

install_neovim_os() {
  local os="$1"

  if [[ $os == "MacOS" ]]; then
    brew install neovim
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" ]]; then
    sudo apt-get install neovim
  fi

  if [[ $os == "rhel" ]]; then
    sudo yum -y install epel-release
    curl -o /etc/yum.repos.d/dperson-neovim-epel-7.repo https://copr.fedorainfracloud.org/coprs/dperson/neovim/repo/epel-7/dperson-neovim-epel-7.repo 
    sudo yum -y install neovim
  fi

  return 0
}

install_htop() {
  local os="$1"

  if htop -v; then
    echo "htop installed!"
    return 0
  else
    echo "htop not installed"
    echo "installing htop..."
    install_htop_os $os
  fi

}

install_htop_os() {
  local os="$1"

  if [[ $os == "MacOS" ]]; then
    brew install htop
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" ]]; then
    sudo apt-get install htop
  fi

  if [[ $os == "rhel" ]]; then
    wget http://packages.sw.be/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
    rpm -ihv rpmforge-release*.rf.x86_64.rpm
    sudo yum install htop
  fi

  return 0
}

download_files() {
  mkdir -p ~/.warp/bin

  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/vimrc --output ~/.warp/vimrc
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/config/tmux.conf --output ~/.warp/tmux.conf
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/tmux-session.sh --output ~/.warp/bin/tmux-session.sh
  curl -s https://raw.githubusercontent.com/collettiquette/warp/master/bin/aliases.sh --output ~/.warp/bin/aliases.sh

  chmod +x ~/.warp/bin/tmux-session.sh
  chmod +x ~/.warp/bin/aliases.sh
}

install_conf() {
  local config_file="$1"
  local backup="$config_file.bak"

  if [[ -e $config_file ]]; then
    mv ~/.$config_file ~/.$backup
  fi

  mv ~/.warp/$config_file ~/.$config_file
}

check_dependencies() {
  local os=$(host_os)
  is_valid_os $os
  install_tmux $os
  install_htop $os
  install_neovim $os
}

main() {
  check_dependencies
  download_files
  install_conf "tmux.conf"
  install_conf "vimrc"
  exec $SHELL
  source ~/.warp/bin/aliases.sh
}

main "$@"
