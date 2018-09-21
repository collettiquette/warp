# Warp
Utility to quickly setup my preferred development environment.

## Install
`curl -sL warp.ha1.io | bash -e`

## OS Support
* MacOS
* Debian / Ubuntu
* Fedora / CentOS / RHEL

## What it Should Do
* Check Host OS
* Check Tmux installation
  * Check/Install Build Prerequisites for Tmux
* Check NeoVim installation
  * Check/Install Build Prerequisites for NeoVim
* Install Plug
  * Install Plugins
    * Check/Install Plugin dependencies
* Check zsh installation
  * Check/Install Build Prerequisites for Zsh
  * Add Oh My Zsh
  * Add dependencies for zsh plugins
  * Install zsh plugins
* Alias commands for environment
* Only makes additive changes / easy to remove
* Starts ZSH session with aliases, starts tmux with specific window/pane config

## What it Aliases
* ktmux (starts with pane/window configuration)
* kvim (specific neovim install)
* t (tree)
* kdel (deletes environment)

