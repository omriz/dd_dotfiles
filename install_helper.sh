#!/usr/bin/env bash

# Setting up git credentials
git config --global user.name "Omri Zohar"
git config --global user.email "omri.zohar@datadoghq.com"
git config --global url."git@github.com:".insteadOf "https://github.com/"
git config --global push.autoSetupRemote true

# Updating bashrc
cat >> ~/.bashrc <<EOL
ddtool auth token registry --datacenter us1.ddbuild.io >> /dev/null
if [ -f "\$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source \$HOME/.bash-git-prompt/gitprompt.sh
fi
if [[ \$- =~ i ]] && [[ -z "\$TMUX" ]] && [[ -n "\$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
EOL

sudo apt-get update && sudo apt-get -q -y upgrade
sudo apt-get -q -y install vim tmux curl git psmisc htop
mv ~/dotfiles/.vimrc ~/.vimrc
mv ~/dotfiles/.bldg.yml ~/.bldg.yml
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Initial setup - please wait"
mv ~/.gitconfig ~/.gitconfig.bck
/usr/bin/git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
/usr/bin/vim +PlugInstall +qall
mv ~/.gitconfig.bck ~/.gitconfig
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
