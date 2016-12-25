" don't bother with vi compatibility
set nocompatible

" Environment

" Identify platform
silent function! OSX()
return has('macunix')
        endfunction
        silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction

" Windows Compatible
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

if !WINDOWS()
    set shell=/bin/sh
endif

" enable syntax highlighting
syntax enable

" Initialize directories
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:consolidated_directory = <full path to desired directory>
    "   eg: let g:consolidated_directory = $HOME . '/.vim/'
    if exists('g:consolidated_directory')
        let common_dir = g:consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

" configure Vundle
filetype on " without this vim emits a zero exit status, later, because of :ft off
filetype off
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged by
" default)
call plug#begin('~/.vim/plugged')

" install plugins
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif
"
" Add plugins to &runtimepath
call plug#end()

" ensure ftdetect et al work by including this after the Vundle stuff
filetype plugin indent on

scriptencoding utf-8

set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " see :help crontab
set directory-=.                                             " don't store swapfiles in the current directory
set encoding=utf-8
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set laststatus=2                                             " always show statusline
set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫,extends:#,nbsp:.
set number                                                   " show line numbers
set ruler                                                    " show where you are
set scrolloff=3                                              " show context above/below cursorline
set showcmd                                                  " Show (partial) command in the last line of the screen
set smartcase                                                " case-sensitive search if any caps
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu                                                 " show a navigable menu for tab completion
set wildmode=longest,list,full
set viewoptions=folds,options,cursor,unix,slash              " Better Unix / Windows compatibility
set history=1000                                             " Store a ton of history (default is 20)
set virtualedit=onemore                                      " Allow for cursor beyond last character
set showmatch                                                " Show matching brackets/parenthesis
set incsearch                                                " Find as you type search
set hidden                                                   " When a buffer becomes hidden when it is abandoned
"set hlsearch                                                 " Highlight search terms

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=syntax

if &term =~ "256"                                            " if we should use 256 colors
    set t_Co=256
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if (&t_Co == 256 || has('gui_running'))
    colorscheme gruvbox
else
    colorscheme wombat
endif

set background=dark                                          " use dark background

if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
endif

set mouse=a                                                  " Enable basic mouse behavior such as resizing buffers
set mousehide                                                " Hide the mouse cursor while typing

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Multi-encoding Setting
" Auto detect Asia language environment. your vim should be compiled with multi_byte option
set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
"if has("multi_byte")
"    "set bomb
"    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
"    " CJK environment detection and corresponding setting
"    if v:lang =~ "^zh_CN"
"        " Use cp936 to support GBK, euc-cn == gb2312
"        set encoding=cp936
"        set termencoding=cp936
"        set fileencoding=cp936
"    elseif v:lang =~ "^zh_TW"
"        " cp950, big5 or euc-tw
"        " Are they equal to each other?
"        set encoding=big5
"        set termencoding=big5
"        set fileencoding=big5
"    elseif v:lang =~ "^ko"
"        " Copied from someone's dotfile, untested
"        set encoding=euc-kr
"        set termencoding=euc-kr
"        set fileencoding=euc-kr
"    elseif v:lang =~ "^ja_JP"
"        " Copied from someone's dotfile, untested
"        set encoding=euc-jp
"        set termencoding=euc-jp
"        set fileencoding=euc-jp
"    endif
"    " Detect UTF-8 locale, and replace CJK setting if needed
"    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
"        set encoding=utf-8
"        set termencoding=utf-8
"        set fileencoding=utf-8
"    endif
"endif


" Formatting
set wrap                        " wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " actual tabs occupy 8 characters ( VIM's default is 8 )
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set colorcolumn=+1              " highlight column after 'textwidth'
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" keyboard shortcuts
"let mapleader = ','
let mapleader = "\<Space>"

" switch windows with two keystroks
" from Ben Klein's post http://blog.unixphilosopher.com/2015/02/five-weird-vim-tricks.html
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Exit insert mode without ESC. uncomment if you need it.
"inoremap jk <Esc>

nmap <leader>xa <Plug>(EasyAlign)
xmap <leader>xa <Plug>(EasyAlign)
nnoremap <leader>/ :Ack!<space>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeToggle<CR>:NERDTreeFind<CR>
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
nnoremap <leader>] :TagbarToggle<CR>
nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>

" reload vimrc
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" Filetype settings
" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile \*.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown
autocmd BufRead,BufNewFile \*.{md,mdwn,mkd,mkdn,markdown} set spell
" extra rails.vim help
autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
" preceding line best in a plugin but here for now.

autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s
" Workaround broken colour highlighting in Haskell
autocmd FileType haskell,rust setlocal nospell

" workaround for LESS & SCSS
autocmd BufRead,BufNewFile *.scss set filetype=scss.css
autocmd FileType scss set iskeyword+=-

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


" PyMode
" Disable if python support not present
if !has('python')
    let g:pymode = 0
endif

if isdirectory(expand("~/.vim/bundle/python-mode"))
    let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
endif

" Fix Cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't copy the contents of an overwritten selection.
vnoremap p "_dP

" Clipboard settings
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IMPORTANT!!!!!!!                                            "
" DO NOT MOVE THE CONTENTS UNLESS YOU KNOW WHAT HOU ARE DOING "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Read plugin settings
"if filereadable(expand("~/.vimrc.plugins"))
"    source ~/.vimrc.plugins
"endif

" Read local settings
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif

" Restore cursor position when reopen a file
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.local file:
"   let g:max_no_restore_cursor = 1
if !exists('g:max_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif
