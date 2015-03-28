" Use Space to open/close folds

" Initialization {{{
set nocompatible " Should be disabled upon finding ~/.vimrc, but better safe than sorry
filetype off " Disable for Vundle
" Vundle & Plugins {{{

if has("unix")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
elseif has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
endif

Plugin 'gmarik/Vundle.vim'

Plugin 'wombat'
Plugin 'solarized'
Plugin 'molokai'
Plugin 'monokai'
Plugin 'hexHighlight.vim'
Plugin 'tabular'

Plugin 'shawncplus/Vim-toCterm'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'mbbill/undotree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'yggdroot/indentline'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'wesQ3/vim-windowswap'

call vundle#end()
" }}}
filetype plugin indent on
" }}}
" Colors and Font {{{
syntax enable " Turn on syntax highlighting

silent! colorscheme wombat " Sets colorscheme

if has('gui_running')
    if has("win32")
        set guifont=consolas:h12 " Change to your liking
    elseif has("unix")
        set guifont=Source\ Code\ Pro\ Medium\ 10 " Change to your liking
    endif
endif

set background=dark " Sets background to be dark (noshitsherlock)
set encoding=utf-8 " Set utf-8 to support more characters
set t_Co=256 " Set terminal-vi to use 256 colors

let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ } " Change color of lightline to match with colorscheme
" }}}
" Indentation {{{
set autoindent " Copy indentation from previous line
set expandtab " Make a tab be spaces
set shiftwidth=4 " Make an indent be 4 spaces
set softtabstop=4 " Remove 4 spaces in sequence if found while backspacing
set tabstop=4 " Set a tab to be 4 spaces large

" Tab can be used anywhere on line to change indent
nnoremap <tab> ==
nnoremap <S-tab> gg=G
" }}}
" Plugin settings {{{
filetype plugin on
let g:NERDTreeWinPos="right" " Align NERDTree to the right
let g:syntastic_cpp_compiler = 'g++' " Set cpp compiler for syntastic to use
let g:syntastic_cpp_compiler_options = '-std=c++11 -Wall -Wextra -pedantic'
" }}}
" Text/File Navigation {{{
"
set nu
set relativenumber " Have line numbers relative to your position
set showmatch " Show opening and closing braces
set wildmenu " Tab completion will show what other files there are
set wrap " Wrap visually but not in buffer

au FocusLost * silent! :set nornu " Disable relative number when unfocused
au FocusGained * silent! :set rnu " Enable relative number when focused

autocmd StdinReadPre * let  s:std_in=1
autocmd vimenter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

autocmd InsertEnter * silent! :set nornu " Disable relative number when in insert mode
autocmd InsertLeave * silent! :set rnu " Enable relative number when in any other

" Move in windows with C-<dir> instead of C-w <dir>
map <C-h> <C-w>h  
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" Easier line navigation
nnoremap B 0
nnoremap E $
" }}}
" Normal Commands {{{
command! W :w " :W will work as :w

:command! Hex :call HexHighlight()
:command! Syntax :call <SID>SynStack() " Find syntax group
:command! SaveSession :call SaveVimSession() " Save session manually
:command! LoadSession :call LoadVimSession() " Load session manually
:command! All :args **/*.cpp | :args **/*.hpp
:command! Nerd :NERDTreeToggle " Open NERDTree, so big
:command! Tbar :TagbarToggle " Open tab bar , so cool
:command! Undo :UndotreeToggle " Open Undotree, so nice
:command! Vimrc :e $HOME/.vim/vimrc " Open .vimrc with a command, so much
:command! Source :source $HOME/.vim/vimrc " Source .vimrc upon writing
:command! Emacs :!cowsay -f /usr/share/cowsay/cows/sodomized-sheep.cow "y u do dis emacs"
" }}}
" Leader Commands {{{
let mapleader = "," " Rebind leader to be comma

" Call :noh upon hitting <leader> + space, removing highlighting from search
nnoremap <leader><space> :noh<CR>
" }}}
" Functions {{{
function! <SID>SynStack()
    if !exists("*synstack") " Check if syntax stack exists
        return
    endif
    " Echo the syntax ID attribute
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SaveVimSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd() " Get directory for where session should be
    if (filewritable(b:sessiondir) != 2) " Check if it isn't possible to write to it
        " If true, create directory for where current session should be
        exe 'silent !mkdir -p ' b:sessiondir
        redraw!
    endif
    " Create name for current session
    let b:filename = b:sessiondir . '/session.vim'
    " Create session
    exe "mksession! " . b:filename
endfunction

function! LoadVimSession()
    " Get session folder
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd() 
    " Get session name
    let b:sessionfile = b:sessiondir . "/session.vim"
    " Check if readable
    if (filereadable(b:sessionfile))
        " If yes, source it
        exe 'source ' b:sessionfile
    else
        " If no, say that no session was loaded
        echo "No session loaded."
    endif
endfunction

" }}}
" Searching {{{
set hlsearch " Highlight search matches
set ignorecase "ignore case in searches
set incsearch " Search while entering word
" }}}
" Folding {{{
set foldenable " Enable folding
set foldlevelstart=10 " Open most folds upon start
set foldmethod=indent " Fold based on indentation
set foldnestmax=0 " Maximum of 10 nested folds

" Use space to toggle folds
nnoremap <space> za
" }}}
" Quality of Life {{{
set cursorline " Make current line stand out
set guioptions=i " Remove toolbar on top, preserve icon in alt-tab
set laststatus=2
set lazyredraw " Redraw only when needed
set nobackup
set noshowmode " Dont show which mode is active, lightline does that
set noswapfile
set nowritebackup " Turn off if vim crashes often
set showcmd " Show the command being entered
set nolist " List fucks wrapping up, so lets disable it

" Increase vertical size of split (window)
map <UP> :winc+<CR>
" Decrease vertical size of split (window)
map <DOWN> :winc-<CR>
" Increase horizontal size of split (window)
map <LEFT> :winc<<CR>
" Decrease horizontal size of split (window)
map <RIGHT> :winc><CR>

" Highlight last inserted text
nnoremap gV `[v`]

" Expand the window so it isn't some small shit on startup
if has("gui_running")
    if has("unix")
    elseif has("win32")
        au GUIEnter * simalt ~x
    endif
endif

" }}}
" File settings {{{
au Filetype make set noexpandtab " Turn of expandtab when in makefiles
au Filetype vim set foldmethod=marker " Use different fold method for vimrc
au Filetype vim set foldlevel=0 " Start with everything folded in vimrc
au Filetype tex colorscheme molokai
" }}}
" Eventual functionality restoration {{{
set backspace=2 " Forces backspace to function as normal
set backspace=indent,eol,start " Allows backspacing across indents, end of lines and start of insertion
" }}}
