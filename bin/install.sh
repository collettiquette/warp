#!/bin/bash -ex

download_files() {
  mkdir ~/.warp
  curl https://github.com/collettiquette/warp/blob/master/config/vimrc --output ~/.warp/vimrc
  curl https://github.com/collettiquette/warp/blob/master/config/tmux.conf --output ~/.warp/tmux.conf
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

