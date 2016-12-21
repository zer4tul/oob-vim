# Out of Box VIM Configration

## Description
oob-vim is a set of configurations for Vim, Gvim and [MacVim].

It makes Vim works out of the box for Unix-like systems, and **maybe** on Windows ( not tested ), too.

## Installation:

## Manually Installation:

### Clone the Git Repo from github:
    git clone git://github.com/zer4tul/vim-config.git ~/.config/vim

### Create symlinks:

    ln -s ~/.config/vim/vimrc ~/.vimrc
    ln -s ~/.config/vim/vimrc.bundles ~/.vimrc.bundles
    ln -s ~/.config/vim/vimrc.plugins ~/.vimrc.plugins

### Switch to the `~/.vim` directory, and fetch Vundle:

    cd ~/.vim
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

## Automatic Installation (TODO):
    ```bash
    curl https://raw.github.com/zer4tul/oom-vim/master/bootstrap.sh -L -o - | sh
    ```

## Note:

* The installation method all above are ONLY FOR UNIX-LIKE SYSTEMS.

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

  ![keyboard_cheatsheet](http://walking-without-crutches.heroku.com/image/images/vi-vim-cheat-sheet.png)

[MacVim]:http://code.google.com/p/macvim/
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
