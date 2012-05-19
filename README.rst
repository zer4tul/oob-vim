===================================
Zer4tul's vim configuration files.
===================================

Installation:
=============

Automatic Installation:
-----------------------
    curl https://raw.github.com/zer4tul/vim-config/master/tools/bootstrap.sh -L -o - | sh

Manually Installation:
----------------------

Clone the Git Repo from github:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    git clone git://github.com/zer4tul/vim-config.git ~/.vim

Create symlinks:
^^^^^^^^^^^^^^^^

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Switch to the `~/.vim` directory, and fetch Vundle:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    cd ~/.vim
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

Note:
=====

* The installation method all above are ONLY FOR UNIX-LIKE SYSTEMS. I'll add the installation method for M$ Windows later.
* The color scheme used by default in the config file is `Solarized`_. And included `flazz's vim-colorschemes colletion`_. If you don't like it, you can spicify another.

Special Thanks To
=================
* gmarik for `vundle`_. Which makes plugin managment much more easier.
* klen for `python-mode`_. Which makes creating python code in vim much more interesting.
* spf13 for his ultra vim config: `spf13-vim`_. It's really awesome. Lot's of settings in this configuration comes from his vimrc file.

Reference
=========
* Vim keyboard cheatsheet
  |keyboard_cheatsheet|

.. _Solarized: http://ethanschoonover.com/solarized
.. _flazz's vim-colorschemes colletion: https://github.com/flazz/vim-colorschemes
.. _vundle: https://github.com/gmarik/vundle
.. _python-mode: https://github.com/klen/python-mode
.. _spf13-vim: https://github.com/spf13/spf13-vim
.. |keyboard_cheatsheet| image:: http://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png 
