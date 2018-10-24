#!/bin/bash -ex

install_plug() {
  curl -fLo ~/.warp/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

main() {
  echo "Plug: Checking installation..."
  echo "Plug: Installing..."
  install_plug
}

main "$@"
