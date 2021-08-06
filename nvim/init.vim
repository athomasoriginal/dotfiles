"" show a vertical bar at 80 characters
set colorcolumn=80
set clipboard=unnamedplus
"" hide the buffers in the background, but don't close them
set hidden
set expandtab
set shiftwidth=4
set scrolloff=8
"" automatically indent at the same lvl as the previous
set smartindent
set softtabstop=4
set tabstop=4
"" prevent copying of line numbers when using a mouse
set mouse+=a
"" prevent the bells when things go wrong
set noerrorbells
"" remove swapfiles - annoying
set noswapfile
set nobackup
"" let me be free and the text go as far and I want it to
set nowrap
set number
set signcolumn=yes
set termguicolors
"" turn of highlighting searches after search
set nohlsearch
"" search as we type
set incsearch

"" escape using jk which feels more ergonomic
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

  "" Markdown stuffs
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  "" Improved commenting
  Plug 'tpope/vim-commentary'

  "" Nunjucks syntax highlighting 
  Plug 'sheerun/vim-polyglot'
  Plug 'lepture/vim-jinja'

  "" File Navigation
  Plug 'preservim/nerdtree'
call plug#end()

colorscheme gruvbox
set bg=dark



"" Telescope stuff
lua << EOF

  require('telescope').setup {
    defaults = {
      file_sorter    = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix  = ' >',
      color_devicons = true,

      file_previwer    = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }

  require('telescope').load_extension('fzy_native')
  require('telescope').load_extension('project')
  require('nvim-treesitter.configs').setup { highlight = { enable = true } }

EOF

"" press space for glory!
let mapleader = " "

"" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fp <cmd>Telescope project<cr>

"" Project File Navigation
map <leader>n :NERDTreeToggle<cr>

"" Save file
nnoremap <C-S> :update<cr>

""" Markdown Syntax Configuration
""" ----------------------------------------------------------------------------

"" au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
let g:markdown_flavor = 'github'

"" Disable automatic folding in vim-markdown
let g:vim_markdown_folding_disabled = 1

"" ****
:hi mkdBold gui=bold guifg=#8f3f71
:hi htmlBold gui=bold guifg=#8f3f71

"" strike through
:hi mkdStrike gui=italic guifg=#af3a03
:hi htmlStrike gui=italic guifg=#af3a03

"" italics
:hi mkdItalic gui=italic guifg=#076678
:hi htmlItalic gui=italic guifg=#076678

"" [link text]: https://hi-there - for regular markdown

:hi link mkdLinkDef GruvboxAqua
:hi link mkdDelimiter GruvboxAqua
:hi link mkdLinkDefTarget  GruvboxBlue

"" make the `#` and `heading text` the same color - less noise
:hi link htmlH1 GruvboxRedBold

"" make the back tickss and `inline-code` the same color
:hi link mkdCode GruvboxOrange
:hi link mkdCodeDelimiter GruvboxOrange
