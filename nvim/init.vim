"" -----------------------------------------------------------------------------
"" Base Settings
"" -----------------------------------------------------------------------------

"" Enable filetype plugins
filetype indent on

"" Keep 10 characters visible above and below the cursor
set scrolloff=8

"" Keep 20 characters visible to the right and left of the cursor
set sidescrolloff=8

"" show a vertical bar at 80 characters
set colorcolumn=80

"" sync your clipboard with system clipboard
set clipboard=unnamedplus

"" hide the buffers in the background, but don't close them
set hidden
set expandtab

"" indentation formatting for new lines
set shiftwidth=2

"" automatically indent at the same lvl as the previous
set smartindent

""
set softtabstop=2

"" Tab width
set tabstop=2

"" prevent copying of line numbers when using a mouse
set mouse+=a

"" prevent bell noise when things go wrong
set noerrorbells

set spell

set title

"" remove swapfiles - annoying
set noswapfile
set nobackup

"" infinite horizontal typing
set nowrap

set splitright

"" Show line numbers
set number

"" Add space to the left column when signs are used e.g. git
set signcolumn=yes:2

"" Use colorschemes you set
set termguicolors

"" Turn of highlighting searches after search
set nohlsearch

"" Search as we type
set incsearch

"" Escape using jk which feels more ergonomic
inoremap jk <ESC>

let g:gruvbox_italic=1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"" The plugins begin
call plug#begin('~/.vim/plugged')
  Plug 'gruvbox-community/gruvbox'
  Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}

  "" Telescope main plugins
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'

  "" Telescope optional plugins
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-telescope/telescope-project.nvim'
  Plug 'nvim-treesitter/playground'
  Plug 'kyazdani42/nvim-web-devicons'

  "" LSP client
  Plug 'neovim/nvim-lspconfig'

  "" Markdown stuffs
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  "" Improved commenting
  Plug 'preservim/nerdcommenter'

  "" Nunjucks syntax highlighting
  Plug 'sheerun/vim-polyglot'
  Plug 'lepture/vim-jinja'

  "" File Navigation
  Plug 'preservim/nerdtree'

  "" Clojure
  Plug 'guns/vim-sexp',    {'for': 'clojure'}
  Plug 'liquidz/vim-iced', {'for': 'clojure'}

  "" JavaScript
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install',
    \ 'for': ['javascript', 'markdown', 'css', 'json'. 'html'] }
call plug#end()
:
colorscheme gruvbox

"" has to be above bg being set below
let g:gruvbox_sign_column = 'bg0'

set bg=dark

" lsp needs to be set after the colorscheme
lua require('init')

" Enable vim-iced's default key mapping
" This is recommended for newbies
let g:iced_enable_default_key_mappings = v:true

"" press space for glory!
let mapleader = "\<Space>"

"" Find files using Telescope command-line sugar.
"" @testing - idea - searching through all projects I have recorded
nnoremap <leader>p <cmd>Telescope project<cr>
nnoremap <leader>f <cmd>Telescope find_files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>

"" @testing - g - meant to replace ctrl+shift+f that im used to
nnoremap <leader>g <cmd>Telescope live_grep<cr>

"" @testing
nnoremap <leader>h <cmd>Telescope help_tags<cr>

"" Project File Navigation
map <leader>n :NERDTreeToggle<cr>

"" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" Remove Trailing Whitespace
" --------------------------

autocmd BufWritePre * :%s/\s\+$//e


"" Save file
"" ---------------
nnoremap <C-S> :update<cr>

"" Nerdtree Config
"" ----------------------------------------------------------------------------

let NERDTreeShowHidden=1

""" Markdown Syntax Configuration
""" ----------------------------------------------------------------------------

"" au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
let g:markdown_flavor = 'github'

"" Disable automatic folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

"" Prevent highlighting spaces in markdown files
hi link mkdLineBreak Normal

"" ****
hi mkdBold gui=bold guifg=#8f3f71
hi htmlBold gui=bold guifg=#8f3f71

"" strike through
hi mkdStrike gui=italic guifg=#af3a03
hi htmlStrike gui=italic guifg=#af3a03

"" italics
hi mkdItalic gui=italic guifg=#076678
hi htmlItalic gui=italic guifg=#076678

"" [link text]: https://hi-there - for regular markdown

hi link mkdLinkDef GruvboxAqua
hi link mkdDelimiter GruvboxAqua
hi link mkdLinkDefTarget  GruvboxBlue

"" make the `#` and `heading text` the same color - less noise
hi link htmlH1 GruvboxRedBold

"" make the back tickss and `inline-code` the same color
hi link mkdCode GruvboxOrange
hi link mkdCodeDelimiter GruvboxOrange

" Custom Syntax Highlighting
" -----------------------------------------------------------------------------
highlight link commentTag Todo
autocmd Syntax * syn match commentTag "@todo" containedin=.*Comment,vimCommentTitle
autocmd Syntax * syn match commentTag "@note" containedin=.*Comment,vimCommentTitle
