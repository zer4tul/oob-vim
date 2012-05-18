#!/usr/bin/env sh

endpath="$HOME/zer4tul-vim-0"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "================================="
echo "Thanks for installing zer4tul-vim"
echo "================================="

# Backup existing .vim stuff
echo "============================="
echo "Backing up current vim config"
echo "============================="
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv $i $i.$today; done


echo "==================="
echo "Cloning zer4tul-vim"
echo "==================="
git clone --recursive http://github.com/zer4tul/vim-config.git $endpath
mkdir -p $endpath/.vim/bundle
ln -sf $endpath/vimrc $HOME/.vimrc
ln -sf $endpath $HOME/.vim

echo "Installing Vundle"
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "installing plugins using Vundle"
vim +BundleInstall! +BundleClean +qa
reset
reset
