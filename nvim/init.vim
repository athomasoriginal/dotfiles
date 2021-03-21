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
call plug#end()

colorscheme gruvbox
set bg=dark

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s+$//e
    call winrestview(l:save)
endfun

augroup THOMAS
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
