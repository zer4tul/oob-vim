Zer4tul's vim configuration files.
===================================

Installation:
-------------

### Automatic Installation:
    curl https://raw.github.com/zer4tul/vim-config/master/tools/bootstrap.sh -L -o - | sh

### Manually Installation:

#### Clone the Git Repo from github:
    git clone git://github.com/zer4tul/vim-config.git ~/.vim

#### Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

#### Switch to the `~/.vim` directory, and fetch Vundle:

    cd ~/.vim
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

Note:
-----

* Till now, the installation method all above are for Unix-like systems ONLY. I'll add the installation method for M$ Windows later.
* The color scheme used by default in the config file is [Solarized](http://ethanschoonover.com/solarized). If you don't like it, you may take a look at [here](http://www.vim.org/scripts/script.php?script_id=625), and manually install the color schemes to .vim.
