" Use Space to open/close folds

" Initialization {{{
set nocompatible " Should be disabled upon finding ~/.vimrc, but better safe than sorry
filetype off " Disable for Vundle
" Vundle & Plugins {{{

" Setup vundle for most operating systems
if has("unix")
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
elseif has("win32")
    set rtp+=~/vimfiles/bundle/Vundle.vim
    let path='~/vimfiles/bundle'
    call vundle#begin(path)
endif


Plugin 'gmarik/Vundle.vim'

Plugin 'VisIncr' " Generate incremented numbers from V-Block selections using :I# (dec), :IO# (oct), :IX# (hex)or similar, all commands can be found on sourceforge page.
Plugin 'Scrooloose/nerdcommenter' " Comment marked blocks using <leader>cs, uncomment with <leader>cu. (Other options than <leader>cs exists, found on github page.)
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree' " Directory tree, open with :Nerd or Ctrl+n
Plugin 'mbbill/undotree' " Visualisation of the undo tree, open with :Undo
Plugin 'majutsushi/tagbar' " Class outline viewer, open with :Tagbar
Plugin 'jreybert/vimagit' " Git wrapper similar to Magit for emacs.
Plugin 'jlanzarotta/bufexplorer' " Dependency for minibufexpl
Plugin 'fholgado/minibufexpl.vim' " Shows buffers in a split at the top of the window.

call vundle#end()
" }}}
filetype plugin indent on
" }}}
" Colors and Font {{{
syntax enable " Turn on syntax highlighting

silent! colorscheme gruvbox " Sets colorscheme

if has("win32")
    set guifont=consolas:h12 " Change to your liking
elseif has("unix")
    set guifont=Hack\ 10 " Change to your liking
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

" Tab can be used anywhere on line to properly indent
nnoremap <tab> ==
" Properly indent whole file using Shift+Tab
nnoremap <S-tab> gg=G
" }}}
" Plugin settings {{{
filetype plugin on
let g:NERDTreeWinPos="right" " Align NERDTree to the right
let g:instant_markdown_autostart = 0
" }}}
" Text/File Navigation {{{
"
set nu " Enable line numbers
set relativenumber " Have line numbers relative to your position
set showmatch " Show opening and closing braces
set wildmenu " Tab completion will show what other files there are
set wrap " Wrap visually but not in buffer

autocmd InsertEnter * silent! :set nornu " Disable relative number when in insert mode
autocmd InsertLeave * silent! :set rnu " Enable relative number when in any other

" Move in windows with C-<dir> instead of C-w <dir>
map <C-h> <C-w>h  
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k

" }}}
" Normal Commands {{{
command! W :w " :W will work as :w

" Bind Ctrl+n to toggle nerdtree
map <C-n> :NERDTreeToggle<CR>
:command! Syntax :call <SID>SynStack() " Find syntax group
:command! SaveSession :call SaveVimSession() " Save session manually
:command! LoadSession :call LoadVimSession() " Load session manually
:command! All :args **/*.cpp | :args **/*.hpp
:command! Nerd :NERDTreeToggle " Open NERDTree, so big
:command! Tbar :TagbarToggle " Open tab bar , so cool
:command! Undo :UndotreeToggle " Open Undotree, so nice
:command! Vimrc :e $HOME/.vim/vimrc " Open .vimrc with a command, so much
:command! Source :source $HOME/.vim/vimrc " Source .vimrc upon writing
" }}}
" Leader Commands {{{
let mapleader = "," " Rebind leader to be comma

" <leader>cc -- Comment line/selection
" <leader>cs -- Comment line/selection 'sexily'
" <leader>cu -- Uncomment line
" Call :noh upon hitting <leader> + space, removing highlighting from search
nnoremap <leader><space> :noh<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>g :Magit<CR>
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
set foldlevelstart=0 " Have all folds closed at the start
set foldmethod=marker " Fold based on markers ({{{ Fold }}})
set foldnestmax=0 " Maximum of 10 nested folds

" Use space to toggle folds
nnoremap <space> za
" }}}
" Quality of Life {{{
set cursorline " Make current line stand out
set guioptions=i " Remove toolbar on top, preserve icon in alt-tab
set laststatus=2 " Always show statusline
set lazyredraw " Redraw only when needed
set nobackup
set noswapfile
set noshowmode " Dont show which mode is active, lightline does that
set nowritebackup " Turn off if vim crashes often
set showcmd " Show the command being entered

" Set some character representations
set list
set listchars=eol:$,tab:>-,trail:~

" Highlight last inserted text
nnoremap gV `[v`]
" }}}
" File settings {{{
au Filetype make set noexpandtab " Turn of expandtab when in makefiles
au Filetype vim set foldmethod=marker " Use different fold method for vimrc
au Filetype vim set foldlevel=0 " Start with everything folded in vimrc
au Filetype tex set linebreak " Don't linebreak in the middle of a word, only certain characters (Can be configured IIRC)
au Filetype tex set nolist " tex files still need nolist for proper linebreaks
au Filetype tex set nowrap " Don't wrap across lines, break the line instead, tex doesn't care if there's only one linebreak, large wrapped lines creates lag when scrolling using j/k
au Filetype tex set tw=65 " Don't let a line exceed 150 characters
" }}}
" Eventual functionality restoration {{{
" Backspace lost functionality an a windows machine, these lines solved it.
" They are not needed if that problem doesn't exist, but they doesn't hurt.
set backspace=2 " Forces backspace to function as normal
set backspace=indent,eol,start " Allows backspacing across indents, end of lines and start of insertion
" }}}
