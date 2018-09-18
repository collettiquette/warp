#!/bin/bash -ex

download_files() {
  mkdir -p ~/.warp/bin

  curl https://raw.githubusercontent.com/collettiquette/warp/master/config/vimrc --output ~/.warp/vimrc
  curl https://raw.githubusercontent.com/collettiquette/warp/master/config/tmux.conf --output ~/.warp/tmux.conf
  curl https://raw.githubusercontent.com/collettiquette/warp/master/bin/tmux-session.sh --output ~/.warp/bin/tmux-session.sh
  chmod +x ~/.warp/bin/tmux-session.sh
  alias ktmux ~/.warp/bin/tmux-session.sh
}

install_tmux_conf() {
  if [[ -e ~/.tmux.conf ]]; then
    mv ~/.tmux.conf ~/.tmux.conf.bak
  fi

  mv ~/.warp/tmux.conf ~/.tmux.conf
}

install_vimrc() {
  if [[ -e ~/.vimrc ]]; then
    mv ~/.vimrc ~/.vimrc.bak
  fi

  mv ~/.warp/vimrc ~/.vimrc
}


main() {
  download_files
  install_tmux_conf
  install_vimrc
  exec $SHELL
}

main "$@"
