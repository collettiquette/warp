#!/bin/bash -ex

install_neovim_mac() {
	local install_dir=~/.warp/nvim-macos.tar.gz

	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz -o $install_dir
	tar xzf $install_dir
	rm -rf $install_dir

	mv ~/.warp/.nvim-osx64/bin/nvim ~/.warp/bin/nvim
}

install_neovim_debian() {
  local user="$(whoami)"
  sudo apt install fuse
  sudo modprobe fuse
  sudo groupadd fuse

  sudo usermod -a -G fuse $user
  install_neovim
}

install_neovim_rhel() {
  local user="$(whoami)"
  sudo yum --enablerepo=epel -y install fuse-sshfs # install from EPEL
  sudo usermod -a -G fuse "$user"
  install_neovim
}


install_appimage() {
	local install_dir=~/.warp/nvim.appimage

  curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $install_dir
	chmod u+x $install_dir

	mv ~/.warp/nvim.appimage ~/.warp/bin/nvim
}

install_neovim() {
	local os="$1"

  if [[ $os == "MacOS" ]]; then
		install_neovim_mac
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" ]]; then
		install_neovim_debian
  fi

  if [[ $os == "rhel" ]]; then
    install_neovim_rhel
  fi

  return 0
}

main() {
  echo "Neovim: Checking installation..."
	local os="$1"
	install_neovim $os
  echo "Neovim: Installing..."
}

main "$@"
