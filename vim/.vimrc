"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/tpope/vim-pathogen/issues/50
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocp
if exists('$DOTFILES')
  source $DOTFILES/vim/autoload/pathogen.vim
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen runtime
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect('bundle/{}', '$DOTFILES/vim/bundle/{}')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" base settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

set colorcolumn=90
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
    colorscheme solarized
catch
endtry

set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" activate insert mode
:inoremap jj <Esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" better vim search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight search results
set hlsearch



