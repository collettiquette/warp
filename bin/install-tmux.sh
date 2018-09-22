#!/bin/bash -ex

install_libevent() {
  wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
  tar xvf libevent-2.0.22-stable.tar.gz
  cd libevent-2.0.22-stable
  ./configure --prefix=$HOME/.warp
  make
  make install
}

install_tmux() {
  wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
  tar xvf tmux-2.2
  ./configure --prefix=$HOME/.warp CFLAGS="-I$HOME/.warp/include" LDFLAGS="-L$HOME/.warp/lib"
  make
  make install
}

main() {
  install_libevent
  install_tmux
}

main "$@"
