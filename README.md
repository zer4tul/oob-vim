# Out of Box VIM Configration

[![Build Status](https://travis-ci.org/zer4tul/oob-vim.svg?branch=master)](https://travis-ci.org/zer4tul/oob-vim)

## Description

oob-vim is a set of configurations for Vim, [NeoVim][Neovim], Gvim and [MacVim].

It makes Vim works out of the box for Unix-like systems, and **maybe** on Windows ( not tested ), too.

## Installation

## Manually Installation

### Clone the Git Repo from github

    git clone git://github.com/zer4tul/oob-vim.git ~/.oob-vim

### Create symlinks

for vim:

    ln -s ~/.oob-vim ~/.vim

for NeoVim

    ln -s ~/.oob-vim ~/.config/nvim

### Install plugins

for vim:

    vim +PlugInstall +qa

for NeoVim:

    nvim +PlugInstall +qa

## Automatic Installation

Install oob-vim for both vim and NeoVim:

    curl -sLf https://raw.githubusercontent.com/zer4tul/oob-vim/master/install.sh | bash

Install oob-vim for vim:

    curl -sLf https://raw.githubusercontent.com/zer4tul/oob-vim/master/install.sh | bash -- install vim

Install oob-vim for NeoVim:

    curl -sLf https://raw.githubusercontent.com/zer4tul/oob-vim/master/install.sh | bash -- install neovim

**Note:** The installation method all above are ONLY FOR UNIX-LIKE SYSTEMS.

## Customization

* `~/.vimrc.local` --> For common Vim config customizations.
* `~/.gvimrc.local` --> For Gvim/MacVim customizations.
* `~/.vimrc.bndles.local` --> For bundles customizations.
* Default color scheme is [wombat256][wombat256] ( for 256-color terminals ) or [wombat][wombat]. And included [flazz's vim-colorschemes colletion][flazz's vim-colorschemes colletion] & [Base16][Base16]. If you don't like the default one, you can spicify another.

## Special Thanks To

* [junegunn][junegunn] for [vim-plug][vim-plug]. Which makes plugin managment much more easier.
* [Steve Francia][Steve Francia] for his ultra vim config: [spf13-vim][spf13-vim]. It's really awesome. Lot's of settings in this configuration comes from his vimrc file.
* [Dave Halter][Dave Halter] for autocompletion library for python named [Jedi][Jedi] and [jedi-vim][jedi-vim] Vim plugin.

## Additional Syntaxes

* Markdown ( bound to \*.md, \*.mdwn, \*.mkd, \*.mkdn, \*.markdown )
* Golang
* SASS

## Reference

* Vim keyboard cheatsheet

  ![keyboard_cheatsheet](http://idarkside.org/images/vi-vim-cheat-sheet.svg)

[Neovim]:https://neovim.io
[MacVim]:http://macvim.org
[Base16]: https://github.com/chriskempson/base16-vim
[wombat256]: http://www.vim.org/scripts/script.php?script_id=2465
[wombat]: http://www.vim.org/scripts/script.php?script_id=1778
[flazz's vim-colorschemes colletion]: https://github.com/flazz/vim-colorschemes
[junegunn]: https://github.com/junegunn
[vim-plug]:https://github.com/junegunn/vim-plug
[Steve Francia]: http://spf13.com/
[spf13-vim]: https://github.com/spf13/spf13-vim
[Dave Halter]: http://jedidjah.ch
[Jedi]: https://github.com/davidhalter/jedi
[jedi-vim]: https://github.com/davidhalter/jedi-vim
