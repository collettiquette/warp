#!/bin/bash -ex

install_neovim_mac() {
	local install_dir=~/.warp/nvim-macos.tar.gz

	curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz -o $install_dir
	tar xzf $install_dir
	rm -rf $install_dir

	mv ~/.warp/.nvim-osx64/bin/nvim ~/.warp/bin/nvim
}

install_neovim_linux() {
	local install_dir=~/.warp/nvim.appimage

  curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o $install_dir
	chmod u+x $install_dir

	cd ~/.warp && ~/.warp/nvim.appimage --appimage-extract
  mv ~/.warp/squashfs-root/AppRun ~/.warp/bin/nvim
}


install_neovim() {
	local os="$1"

  if [[ $os == "MacOS" ]]; then
		install_neovim_mac
  fi

  if [[ $os == "Ubuntu" || $os == "Debian" || $os == "rhel" ]]; then
		install_neovim_linux
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
