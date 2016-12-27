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

Plugin 'AutoComplPop' " Nice wrapper to OmniComplete
Plugin 'Scrooloose/nerdcommenter' " Quick commenting
Plugin 'morhetz/gruvbox'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree' " Directory tree, open with :Nerd or Ctrl+n
Plugin 'mbbill/undotree' " Visualisation of the undo tree
Plugin 'majutsushi/tagbar' " File content viewer
Plugin 'jreybert/vimagit' " Git wrapper similar to Magit for emacs,
                          " really nice for staging small sections
Plugin 'tpope/vim-fugitive' " Another git wrapper, much nicer in other aspects
Plugin 'jlanzarotta/bufexplorer' " Practically :buffers with sorting
Plugin 'fholgado/minibufexpl.vim' " Simple overhead of buffer numbers
Plugin 'raimondi/delimitMate'  " autoclose delimiters, smart closing of delimiters
Plugin 'justincampbell/vim-eighties' " Automatically resize active window
Plugin 'a.vim' " Toggle between source and header files in c and c++
Plugin 'suan/vim-instant-markdown' " Vim plugin for use together with
                                   " instant-markdown, great for writing markdown files
Plugin 'airblade/vim-gitgutter' " Show git diff on sign column, stage individual hunks

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
" }}}
" Plugin settings {{{
filetype plugin on
let g:NERDTreeWinPos="right" " Align NERDTree to the right
let g:instant_markdown_autostart = 0 " Start instant-markdown manually
let delimitMate_expand_cr = 1 " Make i{<CR> equivalent to i{<CR>}<ESC>O

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
" }}}
" Keybinds {{{

let mapleader = "\\" " Ensure leader is hack
" Map space to leader through hack, making hack show in showcmd when entering
" leader command
map <space> \

" Toggle folds
nnoremap <leader>.  za
" Remove highlight from previous search
nnoremap <leader>, :noh<CR>
" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>
" Toggle Tagbar
nnoremap <leader>tb :TagbarToggle<CR>
" Toggle vim-magit
nnoremap <leader>g :Magit<CR>
" Open COMMIT_MSG through vim-fugutive
nnoremap <leader>c :Gcommit<CR>
" Push through vim-fugutive
nnoremap <leader>p :Gpush<CR>
" Pull through vim-fugutive
nnoremap <leader>P :Gpull<CR>
" Toggle highlights on gitgutter
nnoremap <leader>tg :GitGutterLineHighlightsToggle<CR>
" Common A commands bound to leader
nnoremap <leader>aa :A<CR>
nnoremap <leader>as :AS<CR>
nnoremap <leader>av :AV<CR>

" Move current line up or down using arrow keys
nnoremap <up> ddkP
nnoremap <down> ddp
" Tab can be used anywhere on line to properly indent
nnoremap <tab> ==
" Properly indent whole file using Shift+Tab
nnoremap <S-tab> gg=G
" Bind Ctrl+n to toggle NERDTreeToggle
nnoremap <C-n> :NERDTreeToggle<CR>
" Move in windows with C-<dir> instead of C-w <dir>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" Highlight last inserted text
nnoremap gV `[v`]
" }}}
" Normal Commands {{{
command! W :w " :W will work as :w

:command! LoadSession :call LoadVimSession() " Load session manually
:command! Nerd :NERDTreeToggle " Open NERDTree.
:command! SaveSession :call SaveVimSession() " Save session manually
:command! Source :source $HOME/.vim/vimrc " Source .vimrc upon writing
:command! Syntax :call <SID>SynStack() " Find syntax group
:command! Tbar :TagbarToggle " Open tab bar
:command! Vimrc :e $HOME/.vim/vimrc " Open .vimrc with a command
:command! Undo :UndotreeToggle " Open Undotree
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
set foldnestmax=0 " Maximum amount of nested folds
" }}}
" Quality of Life {{{
set cursorline " Make current line stand out
set guioptions=i " Remove toolbar on top, preserve icon in alt-tab
set laststatus=2 " Always show statusline
set lazyredraw " Redraw only when needed
set noshowmode " Dont show which mode is active, lightline does that
set showcmd " Show the command being entered

set nowritebackup " Turn off if vim crashes often
set nobackup
set noswapfile

" Set some character representations
set list
set listchars=eol:$,tab:>-,trail:~

" Disable Nul/C-Space, making entering C-Space harmless
" Both are good to have as different terminal emulators
" can apparently send the combination differently
imap <Nul> <Nop>
imap <C-Space> <Nop>
" }}}
" File settings {{{
au Filetype c setlocal keywordprg=cppman " Use cppman in c files
au Filetype cpp setlocal keywordprg=cppman " Use cppman in c++ files
au Filetype make setlocal noexpandtab " Turn of expandtab when in makefiles
au Filetype vim setlocal foldmethod=marker " Use different fold method for vimrc
au Filetype vim setlocal foldlevel=0 " Start with everything folded in vimrc
au Filetype tex setlocal linebreak " Don't linebreak in the middle of a word, only certain characters (Can be configured IIRC)
au Filetype tex setlocal nolist " tex files still need nolist for proper linebreaks
au Filetype tex setlocal nowrap " Don't wrap across lines, break the line instead, tex doesn't care if there's only one linebreak, large wrapped lines creates lag when scrolling using j/k
au Filetype tex setlocal tw=65 " Don't let a line exceed 150 characters
au Filetype gnugo setlocal nocursorline
" }}}
" Eventual functionality restoration {{{
" Backspace lost functionality an a windows machine, these lines solved it.
" They are not needed if that problem doesn't exist, but they doesn't hurt.
set backspace=2 " Forces backspace to function as normal
set backspace=indent,eol,start " Allows backspacing across indents, end of lines and start of insertion
" }}}
