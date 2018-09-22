#!/bin/bash -ex

install_libevent() {
  curl -L https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz -o ~/.warp/libevent-2.0.22-stable.tar.gz
  cd ~/.warp && tar xvf libevent-2.0.22-stable.tar.gz
  cd ~/.warp/libevent-2.0.22-stable && ./configure --prefix=$HOME/.warp
  cd ~/.warp/libevent-2.0.22-stable && make
  cd ~/.warp/libevent-2.0.22-stable && make install
}

install_tmux() {
  curl -L https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz -o ~/.warp/tmux-2.2.tar.gz
  cd ~/.warp && tar xvf tmux-2.2.tar.gz
  cd ~/.warp/tmux-2.2 && ./configure --prefix=$HOME/.warp CFLAGS="-I$HOME/.warp/include" LDFLAGS="-L$HOME/.warp/lib"
  cd ~/.warp/tmux-2.2 && make
  cd ~/.warp/tmux-2.2 && make install
}

main() {
  install_libevent
  install_tmux
}

main "$@"
