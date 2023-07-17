#!/usr/bin/env bash

# Setting up git credentials
git config --global user.name "Omri Zohar"
git config --global user.email "omri.zohar@datadoghq.com"

# Updating bashrc
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
cat >> ~/.bashrc <<EOL
ddtool auth token registry --datacenter us1.ddbuild.io
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source $HOME/.bash-git-prompt/gitprompt.sh
fi
if [[ $- =~ i ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
EOL

# Installing some things
sudo apt-get update && sudo apt-get -q upgrade
sudo apt-get -q vim tmux curl

# Configuring VIM
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
