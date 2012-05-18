#!/usr/bin/env sh

endpath="$HOME/zer4tul-vim-0"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing zer4tul-vim"

# Backup existing .vim stuff
echo "backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv $i $i.$today; done


echo "cloning zer4tul-vim\n"
git clone --recursive http://github.com/zer4tul/vim-config.git $endpath
mkdir -p $endpath/.vim/bundle
ln -s $endpath/vimrc $HOME/.vimrc
ln -s $endpath $HOME/.vim

echo "Installing Vundle"
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "installing plugins using Vundle"
vim -u "NONE" +BundleInstall! +BundleClean +q
