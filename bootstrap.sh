set -e

echo "Moving to home directory..."
cd

echo "Installing vim, git, zsh, tmux..."
sudo apt-get install -y vim git zsh tmux > /dev/null

echo "Setting up git..."
git config --global user.email "mar.rozycki@gmail.com"
git config --global user.name "Mariusz Różycki"

echo "Setting zsh as default shell..."
sudo usermod -s /bin/zsh $USER

echo "Cloning dotfiles repo..."
git clone https://github.com/mrozycki/dotfiles .dotfiles

echo "Building symlinks to dotfiles..."
for v in `ls .dotfiles` 
do
    ln -s ~/.dotfiles/$v ~/.$v
done

echo "Bootstrapping Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall

echo "All done!"
