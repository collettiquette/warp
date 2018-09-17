#!/bin/bash -ex

download_files() {
  mkdir ~/.warp
  curl https://raw.githubusercontent.com/collettiquette/warp/master/config/vimrc --output ~/.warp/vimrc
  curl https://raw.githubusercontent.com/collettiquette/warp/master/config/tmux.conf --output ~/.warp/tmux.conf
}

install_tmux_conf() {
  mv ~/.tmux.conf ~/.tmux.conf.bak
  mv ~/.warp/tmux.conf ~/.tmux.conf
}

install_vimrc() {
  mv ~/.vimrc ~/.vimrc.bak
  mv ~/.warp/vimrc ~/.vimrc
}


main() {
  download_files
  install_tmux_conf
  install_vimrc
}

main "$@"
