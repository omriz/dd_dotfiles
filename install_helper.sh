#!/usr/bin/env bash

# Setting up git credentials
git config --global user.name "Omri Zohar"
git config --global user.email "omri.zohar@datadoghq.com"
git config --global url."git@github.com:".insteadOf "https://github.com/"
git config --global push.autoSetupRemote true
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
git config --global merge.conflictStyle zdiff3
git config --global delta.side-by-side true


cat >> ~/.zshrc <<EOL
ddtool auth token registry --datacenter us1.ddbuild.io >> /dev/null
if [[ \$- =~ i ]] && [[ -z "\$TMUX" ]] && [[ -n "\$SSH_TTY" ]]; then
  tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi
alias vim=nvim
EOL


echo "Initial setup - please wait"
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt-get update && sudo apt-get -q -y upgrade
sudo apt-get -q -y install neovim tmux curl git psmisc htop python3-pynvim
wget https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
sudo dpkg -i git-delta_0.18.2_amd64.deb
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mv ~/.gitconfig ~/.gitconfig.bck
go install github.com/bazelbuild/buildtools/buildifier@latest
go install github.com/rakyll/gotest@latest
mv ~/.gitconfig.bck ~/.gitconfig
mkdir -p ~/.config/nvim
cp ~/dotfiles/.vimrc ~/.config/nvim/init.vim
/usr/bin/nvim +PlugInstall +qall
sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
