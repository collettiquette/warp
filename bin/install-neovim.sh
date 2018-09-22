#!/bin/bash -ex

install_neovim_mac() {
	local install_dir=~/.warp/nvim-macos.tar.gz

	curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz --outfile $install_dir
	tar xzf $install_dir
	rm -rf $install_dir

	mv ~/.warp/.nvim-osx64/bin/nvim ~/.warp/bin/nvim
}

install_neovim_linux() {
	local install_dir=~/.warp/nvim.appimage

  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --outfile $install_dir
	chmod u+x $install_dir

	mv ~/.warp/bin/nvim.appimage ~/.warp/bin/nvim
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
	local os="$1"
  echo "This is the os: $os"
	install_neovim $os
}

main "$@"
