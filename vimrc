"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialization {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Encoding Setting {{{2
" use utf-8 to save files it should be set before scriptencoding.
set encoding=utf-8

" this script has been writen in utf-8 encoding
scriptencoding utf-8

set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1 " try fileencodings below.
                                                                " your vim should be compiled with multi_byte option
"}}}

" don't bother with vi compatibility, default is off when $HOME/.vimrc or
" .gvimrc exists. just ensure.
set nocompatible


" Identify platform {{{2
silent function! OSX()
return has('macunix')
        endfunction
        silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction
"}}}

" Windows Compatible {{{2
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

if !WINDOWS()
    set shell=/bin/sh
endif
"}}}

" Initialize directories {{{2
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
        if exists('*mkdir')
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo 'Warning: Unable to create backup directory: ' . directory
            echo 'Try: mkdir -p ' . directory
        else
            let directory = substitute(directory, ' ', '\\\\ ', 'g')
            exec 'set ' . settingname . '=' . directory
        endif
    endfor
endfunction
call InitializeDirectories()
"}}}

" configure plugin manager & install plugins
if filereadable(expand('~/.vimrc.bundles'))
    source ~/.vimrc.bundles
endif

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ensure ftdetect et al work by including this after the plugin manager stuff
" +-----------------------------+-----------+-----------+-----------+
" | command                     | detection | plugin    | indent    |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype on                | on        | unchanged | unchanged |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype off               | off       | unchanged | unchanged |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype plugin on         | on        | on        | unchanged |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype plugin off        | unchanged | off       | unchanged |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype indent on         | on        | unchanged | on        |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype indent off        | unchanged | unchanged | off       |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype plugin indent on  | on        | on        | on        |
" +-----------------------------+-----------+-----------+-----------+
" | :filetype plugin indent off | unchanged | off       | off       |
" +-----------------------------+-----------+-----------+-----------+
filetype plugin indent on

" enable syntax highlighting
syntax enable

set autoread                                                 " reload files when changed on disk, i.e. via `git checkout`
set backspace=2                                              " Fix broken backspace in some setups
set backupcopy=yes                                           " make a copy of the file and overwrite the original one.
set directory-=.                                             " don't store swapfiles in the current directory
set ignorecase                                               " case-insensitive search
set incsearch                                                " search as you type
set smartcase                                                " case-sensitive search if any caps
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc,*.swp,*.bak,*.pyc,*.class,.svn
set wildmode=longest,list,full
set viewoptions=folds,options,cursor,unix,slash              " Better Unix / Windows compatibility
set history=1000                                             " Store a ton of history (default is 20)
set virtualedit=onemore                                      " Allow for cursor beyond last character
set viminfo^=%                                               " Remember info about open buffers on close
set showmatch                                                " Show matching brackets/parenthesis
set incsearch                                                " Find as you type search
set hidden                                                   " When a buffer becomes hidden when it is abandoned
set magic                                                    " It is recommended to always keep the 'magic' option at the default
                                                             " setting, which is 'magic'.  This avoids portability problems.
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI/UX {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showcmd                                                  " Show (partial) command in the last line of the screen

set splitright                                               " Puts new vsplit windows to the right of the current
set splitbelow                                               " Puts new split windows to the bottom of the current

set number                                                   " show line numbers
set laststatus=2                                             " always show statusline
set title                                                    " change terminal title
"set hlsearch                                                " Highlight search terms, maybe will conflict with some colorschemes
set ruler                                                    " show where you are

set completeopt=longest,menu                                 " http://vim.wikia.com/wiki/Improve_completion_popup_menu
set wildmenu                                                 " show a navigable menu for tab completion

" mouse settings
if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
endif

set mouse=a                                                  " Enable basic mouse behavior such as resizing buffers
set mousehide                                                " Hide the mouse cursor while typing


set foldenable                                               " enable folding
set foldmethod=manual                                        " available fold methods:
                                                             " manual(default), indent, expr, syntax, diff, marker


set list                                                     " show trailing whitespace
set listchars=tab:▸\ ,trail:▫,extends:#,nbsp:.

set scrolloff=5                                              " show context above/below cursorline

" automatically rebalance windows on vim resize
augroup resize_window
    autocmd!
    autocmd VimResized * :wincmd =
augroup END

" these two options below will highlight the line/column where the cursor is. may slow down the terminal when
" they turned on
"set cursorline                                               " highlight current line
"set cursorcolumn                                             " highlight current column

" Fix background color render problems in tmux and GNU screen
if &term =~? '256'                                            " if we should use 256 colors
    set t_Co=256
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" Fix Cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" colorscheme setting
if (&t_Co == 256 || has('gui_running'))
    colorscheme gruvbox
else
    colorscheme wombat
endif

set background=dark                                          " use dark background


" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" switch windows with two keystroks
" from Ben Klein's post http://blog.unixphilosopher.com/2015/02/five-weird-vim-tricks.html
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Formatting {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                  " Indent at the same level of the previous line
set wrap                        " wrap long lines

" <Tab> related settings
set shiftwidth=4                " Use indents of 4 spaces
set shiftround                  " Round indent to multiple of 'shiftwidth'.  Applies to > and < commands.
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " actual tabs occupy 8 characters ( VIM's default is 8 )
set softtabstop=4               " Let backspace delete indent

set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set colorcolumn=+1              " highlight column after 'textwidth'

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keyboard shortcuts {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let mapleader = ','
let mapleader = "\<Space>"

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
"nnoremap <leader><space> :call whitespace#strip_trailing()<CR>
nnoremap <leader>g :GitGutterToggle<CR>

" reload vimrc
noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype settings {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fdoc is yaml
augroup filetype_fdoc
    autocmd!
    autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
augroup END
" md is markdown
augroup filetype_markdown
    autocmd!
    autocmd BufRead,BufNewFile \*.{md,mdwn,mkd,mkdn,markdown} set filetype=markdown
    autocmd BufRead,BufNewFile \*.{md,mdwn,mkd,mkdn,markdown} set spell
augroup END

" extra rails.vim help
augroup filetype_rails
    autocmd!
    autocmd User Rails silent! Rnavcommand decorator      app/decorators            -glob=**/* -suffix=_decorator.rb
    autocmd User Rails silent! Rnavcommand observer       app/observers             -glob=**/* -suffix=_observer.rb
    autocmd User Rails silent! Rnavcommand feature        features                  -glob=**/* -suffix=.feature
    autocmd User Rails silent! Rnavcommand job            app/jobs                  -glob=**/* -suffix=_job.rb
    autocmd User Rails silent! Rnavcommand mediator       app/mediators             -glob=**/* -suffix=_mediator.rb
    autocmd User Rails silent! Rnavcommand stepdefinition features/step_definitions -glob=**/* -suffix=_steps.rb
augroup END

augroup filetype_html
    autocmd!
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
augroup END

augroup filetype_haskell
    autocmd!
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
augroup END
" preceding line best in a plugin but here for now.

augroup filetype_coffee
    autocmd!
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
augroup END


" workaround for LESS & SCSS
augroup filetype_css
    autocmd!
    autocmd BufRead,BufNewFile *.scss set filetype=scss.css
    autocmd FileType scss set iskeyword+=-
augroup END

"Python PEP 8 stuff {{{2
augroup filetype_python
    autocmd!
    " Number of spaces that a pre-existing tab is equal to.
    autocmd BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4
    "spaces for indents
    autocmd BufRead,BufNewFile *.py,*pyw set shiftwidth=4
    autocmd BufRead,BufNewFile *.py,*.pyw set expandtab
    autocmd BufRead,BufNewFile *.py set softtabstop=4

    " Display tabs at the beginning of a line in Python mode as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
    " Make trailing whitespace be flagged as bad.
    autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

    " Wrap text after a certain number of characters
    autocmd BufRead,BufNewFile *.py,*.pyw, set textwidth=100

    " Use UNIX (\n) line endings.
    autocmd BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
augroup END

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some tweaks {{{1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use ag over grep
    set grepprg="ag --nogroup --nocolor"
elseif executable('ack')
    " Use ack over grep
    set grepprg="ack -s -H --nocolor --nogroup --column"
endif

" Restore cursor position when reopen a file
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.local file:
"   let g:max_no_restore_cursor = 1
if !exists('g:max_no_restore_cursor')
    function! ResCur()
        if line("'\"") <= line('$')
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
endif

"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" IMPORTANT!!!!!!!                                            "
" DO NOT MOVE THE CONTENTS UNLESS YOU KNOW WHAT HOU ARE DOING "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Read plugin settings
"if filereadable(expand("~/.vimrc.plugins"))
"    source ~/.vimrc.plugins
"endif

" Read local settings
if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" Use local gvimrc if available and gui is running
if has('gui_running')
    if filereadable(expand('~/.gvimrc.local'))
        source ~/.gvimrc.local
    endif
endif

" vim: ft=vim:fdm=marker:et:sw=4:
