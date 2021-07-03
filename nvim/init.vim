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
"" let me be free and the text go as far and I want it to
set nowrap
set number
set signcolumn=yes
set termguicolors

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
  Plug 'nvim-treesitter/playground'
  Plug 'kyazdani42/nvim-web-devicons'
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
  require('nvim-treesitter.configs').setup { highlight = { enable = true } }

EOF

"" press space for glory!
let mapleader = " "

"" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
