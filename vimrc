" Environment
    " Basics
        " Get out of VI's compatible mode.. MUST be first line
        set nocompatible

        " the /g flag on :s substitutions by default
        set gdefault

        " Favorite filetypes
        set ffs=unix,dos,mac

    " Bundle Support
        " The next two lines makes the ~/.vim/bundle/ system works.
        runtime! autoload/pathogen.vim
        silent! call pathogen#helptags()
            silent! call pathogen#runtime_append_all_bundles()
        call pathogen#infect()


    " General
        " Multi-encoding Setting
        " Auto detect Asia language environment. your vim should be compiled with multi_byte option
        if has("multi_byte")
            "set bomb
            set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
            " CJK environment detection and corresponding setting
            if v:lang =~ "^zh_CN"
                " Use cp936 to support GBK, euc-cn == gb2312
                set encoding=cp936
                set termencoding=cp936
                set fileencoding=cp936
            elseif v:lang =~ "^zh_TW"
                " cp950, big5 or euc-tw
                " Are they equal to each other?
                set encoding=big5
                set termencoding=big5
                set fileencoding=big5
            elseif v:lang =~ "^ko"
                " Copied from someone's dotfile, untested
                set encoding=euc-kr
                set termencoding=euc-kr
                set fileencoding=euc-kr
            elseif v:lang =~ "^ja_JP"
                " Copied from someone's dotfile, untested
                set encoding=euc-jp
                set termencoding=euc-jp
                set fileencoding=euc-jp
            endif
            " Detect UTF-8 locale, and replace CJK setting if needed
            if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
                set encoding=utf-8
                set termencoding=utf-8
                set fileencoding=utf-8
            endif
        endif

        " Let vim jump to the last position when reopening a file
        if has("autocmd")
            au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                        \| exe "normal g'\"" | endif
        endif

    " Backup & Undo Settings
        " Turn on backup option
        set backup

        " Turn on undofile ( if your vim compiled with persistent_undo option )
        if has("persistent_undo")
            set undofile
            set undolevels=1000         "maximum number of changes that can be undone
            set undoreload=10000        "maximum number lines to save for undo on a buffer reload
        endif

        " Could use * rather than *.*, but I prefer to leave .files unsaved
        au BufWinLeave *.* silent! mkview  "make vim save view (state) (folds, cursor, etc)
        au BufWinEnter *.* silent! loadview "make vim load view (state) (folds, cursor, etc)

        "Enable filetype plugin
        filetype plugin on
        filetype indent on

        "Set to auto read when a file is changed from the outside
        set autoread

        " syntax highlighting
        syntax on

        " define the encoding of this script
        scriptencoding utf-8


        " Set spell checking on
        "set spell

" UI
    " Colorscheme
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        if has('gui_running')
            colorscheme solarized
        else
            let g:solarized_termcolors=256
            colorscheme solarized
        endif
        let g:solarized_termtrans=0
        let g:solarized_contrast="high"
        let g:solarized_visibility="high"
    endif
  
    " Use mouse
    "set mouse=a

    " Turn on 256 color support
    set t_Co=256

    " Assume a dark background
    set background=dark

    " Display the current mode ( default: on )
    set showmode

    " Hilight current line
    set cursorline

    " Highlight bg color of current line
    hi cursorline guibg=#333333

    " Highlight cursor
    hi CursorColumn guibg=#333333

    " If has multi_byte_ime option change the cursor color when IME on and off
    if has('multi_byte_ime')
        highlight Cursor guibg=#333333 guifg=NONE
        highlight CursorIM guibg=Purple guifg=NONE
    endif

    "Always show current position
    if has('cmdline_info')
        set ruler                  	" show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                	" show partial commands in status line and
        " selected characters/lines in visual mode
    endif

    "Set 7 lines to the curors - when moving vertical..
    " -- Disabled, seems it will increase cpu usage when moving vertical
    "set so=7

    "Turn on wild menu
    set wildmenu

    " command <Tab> completion, list matches, then longest common part, then all.
    set wildmode=list:longest,full

    " Backspace and cursor keys wrap to
    set whichwrap=b,s,h,l,<,>,[,]

    "The commandbar is 2 high
    "set cmdheight=2

    "Show line number
    "set nu

    "Do not redraw, when running macros.. lazyredraw
    "set lz

    "Change buffer - without saving
    "set hid

    " make the popupmenu's colours a little less shit
    highlight   Pmenu               term=NONE cterm=NONE ctermfg=0 ctermbg=27 gui=NONE
    highlight   PmenuSel            term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE
    highlight   PmenuSbar           term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE
    highlight   PmenuThumb          term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE

    " No extra spaces between rows
    set linespace=0

    " Incremental search
    set incsearch

    " set modeline
    set ml

    set linebreak
    "set breakat+=—，。！？

    " set modelines ( default: 5 )
    set mls=5

    "Set backspace
    set backspace=eol,start,indent

    "Ignore case when searching
    set ignorecase

    "Set magic on
    set magic

    " auto fold code
    set foldenable
    ""Enable folding, I find it very useful
    "set nofen
    "set fdl=0

    "No sound on errors.
    set noerrorbells
    set novisualbell
    set t_vb=

    "show matching bracets
    set showmatch

    "How many tenths of a second to blink
    set mat=2

    "Highlight search things
    set hlsearch

    " Highlight problematic whitespace
    "set list
    "set listchars=tab:>.,trail:.,extends:#,nbsp:.

    " Statusline
    " A status line will be used to separate windows
    set laststatus=2

    function! CurDir()
        let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
        return curdir
    endfunction

    "Format the statusline
    if has('statusline')
        "set statusline=%<%F%h%m%r%h%w%y\ [CWD:\ %r%{CurDir()}%h]\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\    " Filename
        set statusline+=%w%h%m%r " Options
        set statusline+=%{fugitive#statusline()} "  Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " filetype
        set statusline+=\ [%{getcwd()}]          " current dir
        "set statusline+=\ [A=\%03.3b/H=\%02.2B] " ASCII / Hexadecimal value of char
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif


    " Make omnicompletation useful
    " http://www.vim.org/tips/tip.php?tip_id=1386
    set completeopt=longest,menuone,preview
    inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
    inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
    inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
    
" Formatting
    " wrap long lines
    set nowrap

    " indent at the same level of the previous line
    set autoindent

    " use indents of 4 spaces
    set shiftwidth=4

    " Smarttab
    set smarttab

    " number of spaces to used by cindent
    set shiftwidth=4

    " tabs are spaces, not tabs
    set expandtab

    " an indentation every four columns
    set tabstop=4

    " let backspace delete indent
    set softtabstop=4

    " match pair, to be used with %
    set matchpairs+=<:>

    " Do smart case matching
    set smartcase

    " Smart indent
    set smartindent

    " Text width
    set textwidth=500

    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,php,js,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

    " Formatting for special file types
    " vim
    " .vim files don't need folding
    autocmd FileType vim set nofen

    " python
        " Auto use template file when create a new python file
"        autocmd BufNewFile test*.py 0r ~/.vim/templates/test.py
"        autocmd BufNewFile alltests.py 0r ~/.vim/templates/alltests.py
"        autocmd BufNewFile *.py 0r ~/.vim/templates/skeleton.py
        autocmd FileType python set tabstop=4
        autocmd FileType python set softtabstop=4
        autocmd FileType python set shiftwidth=4
        autocmd FileType python set expandtab
        autocmd FileType python set autoindent
        autocmd FileType python set foldcolumn=1  " Optional

        " reStructuredText
        autocmd FileType rst set tabstop=4
        autocmd FileType rst set softtabstop=4
        autocmd FileType rst set shiftwidth=4
        autocmd FileType rst set expandtab

        " Markdown
        autocmd FileType markdown set tabstop=4
        autocmd FileType markdown set softtabstop=4
        autocmd FileType markdown set shiftwidth=4
        autocmd FileType markdown set expandtab

" Keymapping
    "Set mapleader
    let mapleader = ","
    let g:mapleader = ","

    " use <F3> to toggle between paste mode and no paste mode.
    set pastetoggle=<F3>

    "Remove indenting on empty lines
    map <F2> :%s/\s*$//g<cr>:noh<cr>''

    " Fast saving
    nmap <leader>w :w!<cr>
    nmap <leader>f :find<cr>
    map <silent><A-Right> :tabnext<CR>
    map <silent><A-Left> :tabprevious<CR>


    " Fast reloading of the .vimrc
    map <leader>s :source ~/.vimrc<cr>
    " Fast editing of .vimrc
    map <leader>e :e! ~/.vimrc<cr>
    " When .vimrc is edited, reload it
    autocmd! bufwritepost vimrc source ~/.vimrc

    " Some nice mapping to switch syntax (useful if one mixes different languages in one file)
    map <leader>p :set syntax=python<cr>
    map <leader>c :set ft=c<cr>
    map <leader>$ :syntax sync fromstart<cr>

    " Change file format quickly
    nmap <leader>fd :se ff=dos<cr>
    nmap <leader>fu :se ff=unix<cr>

    "Remove the Windows ^M
    noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

    " Smart way to move btw. windows & tabs
    map <C-J> <C-W>j<C-W>_
    map <C-K> <C-W>k<C-W>_
    map <C-L> <C-W>l<C-W>_
    map <C-H> <C-W>h<C-W>_

    " Wrapped lines goes down/up to next row, rather than next line in file.
    "nnoremap j gj
    "nnoremap k gk

    " Clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

	" Code folding options
	nmap <leader>f0 :set foldlevel=0<CR>
	nmap <leader>f1 :set foldlevel=1<CR>
	nmap <leader>f2 :set foldlevel=2<CR>
	nmap <leader>f3 :set foldlevel=3<CR>
	nmap <leader>f4 :set foldlevel=4<CR>
	nmap <leader>f5 :set foldlevel=5<CR>
	nmap <leader>f6 :set foldlevel=6<CR>
	nmap <leader>f7 :set foldlevel=7<CR>
	nmap <leader>f8 :set foldlevel=8<CR>
	nmap <leader>f9 :set foldlevel=9<CR>

	" Fix home and end keybindings for screen, particularly on mac
	" - for some reason this fixes the arrow keys too. huh.
	map [F $
	imap [F $
	map [H g0
	imap [H g0

    "Basically you press * or # to search for the current selection !! Really useful
    vnoremap <silent> * :call VisualSearch('f')<CR>
    vnoremap <silent> # :call VisualSearch('b')<CR>

    "Switch to current dir
    "cmap cwd lcd %:p:h
    "cmap cd. lcd %:p:h

    " Parenthesis/bracket expanding
    vnoremap ( <esc>`>a)<esc>`<i(<esc>
    vnoremap [ <esc>`>a]<esc>`<i[<esc>
    vnoremap { <esc>`>a}<esc>`<i{<esc>
    vnoremap " <esc>`>a"<esc>`<i"<esc>
    vnoremap ' <esc>`>a'<esc>`<i'<esc>

    "Map auto complete of (, ", ', [
    "inoremap ( ()<Esc>:let leavechar=")"<CR>i
    "inoremap [ []<Esc>:let leavechar="]"<CR>i
    "inoremap { {}<Esc>:let leavechar="}"<CR>i
    "inoremap < <><Esc>:let leavechar=">"<CR>i

    " Moving around and tabs
    " Closed by default, cause I never use tabs

    "Actually, the tab does not switch buffers, but my arrows
    "Bclose function ca be found in "Buffer related" section
    "map <leader>bd :Bclose<cr>
    "map <down> <leader>bd

    "Use the arrows to something usefull
    "map <right> :bn<cr>
    "map <left> :bp<cr>

    "Tab configuration
    "map <leader>tn :tabnew %<cr>
    "map <leader>te :tabedit
    "map <leader>tc :tabclose<cr>
    "map <leader>tm :tabmove
    "try
    "  set switchbuf=usetab
    "  set stal=2
    "catch
    "endtry

    " Insert system datetime at current position
    imap <F5> <C-R>=strftime("%Y-%m-%d")<CR>
    imap <F6> <C-R>=strftime("%Y-%m-%d %H:%M:%S")<CR>

    " Tag list toggle
    nmap <F8> :TagbarToggle<CR>

    " Resizing windows
    nmap <C-F9> :resize -1<CR>
    nmap <C-F10> :resize +1<CR>
    nmap <C-F11> :vertical resize -1<CR>
    nmap <C-F12> :vertical resize +1<CR>
    nmap <F4> :<ESC>$<ESC>a<br><ESC>
    ino <C-\><C-A> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

    " 手工更新文件最后修改时间
    map ,L :call LastMod()<CR>

" Plugins

    "Bash-Support
        let g:BASH_AuthorName = 'Zer4tul'
        let g:BASH_Email = 'kefei@baidu.com'
        let g:BASH_UserWWW = 'http://www.baidu.com'
        let g:BASH_Company = 'Baidu, Inc.'

    " OmniComplete
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif
        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=gray ctermbg=darkgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " some convenient mappings
        inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set completeopt=menu,preview,longest

    " rfc.vim
    " The following line will make Vim recognize all files with name rfcXXXX as RFC file
    if expand('%:t') =~? 'rfcd+'
        setfiletype rfc
    endif

    " for cscope
        if has("cscope")
            set csprg=/usr/bin/cscope
            set csto=0
            set cst
            set nocsverb
            " add any database in current directory
            if filereadable("cscope.out")
                cs add cscope.out
            " else add database pointed to by environment
            elseif $CSCOPE_DB != ""
                cs add $CSCOPE_DB
            endif
            set csverb
            set cscopetag
            set cscopequickfix=s-,g-,c-,d-,t-,e-,f-,i-
        endif

    " Powerline
        if &encoding == "utf-8"
            let g:Powerline_symbols = 'unicode'
        else
            let g:Powerline_symbols = 'compatible'
        endif

    " Vundle
        filetype off                   " required!
        set rtp+=~/.vim/bundle/vundle/
        call vundle#rc()
        filetype on

        " let Vundle manage Vundle
        " required!
        Bundle 'gmarik/vundle'

        " My Bundles here:
        "
        " original repos on github
        Bundle 'tpope/vim-fugitive'
        Bundle 'Lokaltog/vim-easymotion'
        Bundle 'Lokaltog/vim-powerline'
        Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
        Bundle 'tpope/vim-rails.git'
        Bundle 'altercation/vim-colors-solarized.git'
        Bundle 'wincent/Command-T.git'
        Bundle 'klen/python-mode.git'
        Bundle 'Shougo/neocomplcache'
        "Bundle 'Shougo/neocomplcache-snippets-complete'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'flazz/vim-colorschemes'
        Bundle 'scrooloose/syntastic'
        Bundle 'zer4tul/rfc.vim'
        if executable('ctags')
            Bundle 'majutsushi/tagbar'
        endif
        Bundle 'garbas/vim-snipmate'
        " vim-snipmate depends on vim-addon-mw-utils and tlib_vim, snipmate-snippets provides most complete snippets for it.
        Bundle 'zer4tul/snipmate-snippets'
        Bundle 'MarcWeber/vim-addon-mw-utils'                                                                                                                                                                   
        Bundle 'tomtom/tlib_vim'
        " Source support_function.vim to support snipmate-snippets.
        if filereadable(expand("~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim"))                                                                                                           
            source ~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim
        endif
        

        " vim-scripts repos
        Bundle 'L9'
        Bundle 'FuzzyFinder'
        Bundle 'bash-support.vim'
        Bundle 'python_match.vim'
        Bundle 'pythoncomplete'
        Bundle 'c.vim'
        Bundle 'VimIM'
        " non github repos
        "Bundle 'git://git.wincent.com/command-t.git'
        " ...

        "
        " Brief help
        " :BundleList          - list configured bundles
        " :BundleInstall(!)    - install(update) bundles
        " :BundleSearch(!) foo - search(or refresh cache first) for foo
        " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
        "
        " see :h vundle for more details or wiki for FAQ
        " NOTE: comments after Bundle command are not allowed..

    " Python-Mode
        " Disable if python support not present
        if !has('python')
            let g:pymode = 1
            let g:pymode_lint_checker = "pyflakes"
        endif

    " neocomplcache

        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Use camel case completion.
        let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        let g:neocomplcache_enable_underbar_completion = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
        " Auto insert delimiter ('/' for filename, '#' for vim file)
        let g:neocomplcache_enable_auto_delimiter = 1

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        imap <C-k>     <Plug>(neocomplcache_snippets_expand)
        smap <C-k>     <Plug>(neocomplcache_snippets_expand)
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()

        " SuperTab like snippets behavior.
        "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplcache_enable_auto_select = 1
        "let g:neocomplcache_disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
        "inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
        "autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
        let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        " SnipMate {
            " Setting the author var
            " If forking, please overwrite in your .vimrc.local file
            let g:snips_author = 'Zer4tul Ke <zer4tul@gmail.com>'
        " }


" Functions
    "A function that inserts links & anchors on a TOhtml export.
    " Notice:
    " Syntax used is:
    " Link
    " Anchor
    function! SmartTOHtml()
        TOhtml
        try
            %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
            %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
            %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
        catch
        endtry
        exe ":write!"
        exe ":bd"
    endfunction

    " Virtual search.
    " will search what has been selected
    " From an idea by Michael Naumann
    function! VisualSearch(direction) range
        let l:saved_reg = @"
        execute "normal! vgvy"
        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")
        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        else
            execute "normal /" . l:pattern . "^M"
        endif
        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction

    " 函数，修改文件头部的最后修改时间，就象这个文件的头部一样
    function! LastMod()
        if line("$") > 5
            let l = 5
        else
            let l = line("$")
        endif
        exe "1," . l . "s/[Ll]ast [Mm]odified: .*/Last modified: " . strftime("%c") . " [" . hostname() . "]/e"
    endfunction

    function! InitializeDirectories()
        let separator = "."
        let parent = $HOME
        let prefix = '.vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/' . prefix . dirname . "/"
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

" Read the local customlize file
    " Use local vimrc if available 
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif

    " Use local gvimrc if available and gui is running
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
