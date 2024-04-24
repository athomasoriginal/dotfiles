-- ----------------------------------------------------------------------------
-- Notes
-- ----------------------------------------------------------------------------

-- * Strings - escapes in lua
--   Example: `\e` -> `\\e`
-- * Vim Functions
--   Find them in `vim.fn.`
-- * Vim Options
--   `vim.o` sets global vim options
--   `vim.wo` sets window scoped options
--   `vim.bo` sets buffer scoped options
--   `vim.g` sets global variables
--   `vim.opt` sets global, window and buffer options.  Acts like `:set` in
--   vimscript.

-- ----------------------------------------------------------------------------
-- Options
-- ----------------------------------------------------------------------------

-- Keep 10 characters visible above and below the cursor
vim.opt.scrolloff = 8

-- Keep 20 characters visible to the right and left of the cursor
vim.opt.sidescrolloff = 8

-- show a vertical bar at 80 characters
vim.opt.colorcolumn = "80"

-- sync your clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"

-- hide the buffers in the background, but don't close them
vim.opt.hidden = true
vim.opt.expandtab = true

-- indentation formatting for new lines
vim.opt.shiftwidth = 2

-- automatically indent at the same lvl as the previous
vim.opt.smartindent = true

-- type in lower case or be specific about casing
vim.opt.ignorecase = true
vim.opt.smartcase = true

--
vim.opt.softtabstop = 2

-- set statusline to be global status line
vim.opt.laststatus = 3

-- Tab width
vim.opt.tabstop = 2

-- prevent bell noise when things go wrong
vim.opt.errorbells = true

vim.opt.title = true

-- remove swapfiles - annoying
vim.opt.swapfile = false
vim.opt.backup = false

-- infinite horizontal typing
vim.opt.wrap = false

vim.opt.splitright = true

-- Show line numbers
vim.opt.number = true

-- Add space to the left column when signs are used e.g. git
vim.opt.signcolumn = "yes"

-- Use colorschemes you set
vim.opt.termguicolors = true

-- Hide the mode you're currently in (status bar)
vim.opt.showmode = true

-- Search as we type
vim.opt.incsearch = true

-- True Color Support
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Set the terminal tab title
vim.opt.titlestring = "NVIM - %t"

-- Mouse Support - prevent copying of line numbers when using a mouse (kitty)
vim.opt.mouse = "a"

-- Mouse Support - add terminal support for modern mouse codes (kitty support)
vim.o.ttymouse = "sgr"

-- Mouse Support - baloon popup support
vim.o.balloonevalterm = true

-- Call everything that follows before the theme is set

-- Underline Support - Styled and Colored (kitty support)
vim.o.t_AU = "\\e[58:5:%dm"
vim.o.t_8u = "\\e[58:2:%lu:%lu:%lum"
vim.o.t_Us = "\\e[4:2m"
vim.o.t_Cs = "\\e[4:3m"
vim.o.t_ds = "\\e[4:4m"
vim.o.t_Ds = "\\e[4:5m"
vim.o.t_Ce = "\\e[4:0m"

-- Strikethrough Support
vim.o.t_Ts = "\\e[9m"
vim.o.t_Te = "\\e[29m"

---- True Color Support
vim.o.t_8f = "\\e[38:2:%lu:%lu:%lum"
vim.o.t_8b = "\\e[48:2:%lu:%lu:%lum"
vim.o.t_RF = "\\e]10;?\\e\\"
vim.o.t_RB = "\\e]11;?\\e\\"

---- Bracketed Paste
vim.o.t_BE = "\\e[?2004h"
vim.o.t_BD = "\\e[?2004l"
vim.o.t_PS = "\\e[200~"
vim.o.t_PE = "\\e[201~"

---- Cursor Control
vim.o.t_RC = "\\e[?12$p"
vim.o.t_SH = "\\e[%d q"
vim.o.t_RS = "\\eP$q q\\e\\"
vim.o.t_SI = "\\e[5 q"
vim.o.t_SR = "\\e[3 q"
vim.o.t_EI = "\\e[1 q"
vim.o.t_VS = "\\e[?12l"

---- Focus Tracking
vim.o.t_fe = "\\e[?1004h"
vim.o.t_fd = "\\e[?1004l"

---- Window Title
vim.o.t_ST = "\\e[22;2t"
vim.o.t_RT = "\\e[23;2t"

---- vim hardcodes background color erase even if the terminfo file does
---- not contain bce. This causes incorrect background rendering when
---- using a color theme with a background color in terminals such as
---- kitty that do not support background color erase.

vim.o.t_ut = ""

-- ----------------------------------------------------------------------------
-- Remaps
-- ----------------------------------------------------------------------------

-- press space for glory - should be before lazy.nvim

vim.g.mapleader = " "


-- escape shortcut

vim.keymap.set('i', 'jk', "<ESC>")


-- folder/file navigation

vim.keymap.set('n', '<leader>n', "<cmd>NERDTreeToggle<CR>")

vim.keymap.set('n', '<leader>p', "<cmd>Telescope project<CR>")

vim.keymap.set('n', '<leader>f', "<cmd>Telescope find_files<CR>")

vim.keymap.set('n', '<leader>b', "<cmd>Telescope buffers<CR>")

vim.keymap.set('n', '<leader>g', "<cmd>Telescope live_grep<CR>")

vim.keymap.set('n', '<leader>dl', "<cmd>edit ~/code/dev-log.md<CR>")


-- remove active highlights

vim.keymap.set('n', '<leader>k', "<cmd>nohlsearch<CR>")


-- window navigation

vim.keymap.set('n', '<C-h>', "<C-w>h")

vim.keymap.set('n', '<C-j>', "<C-w>j")

vim.keymap.set('n', '<C-k>', "<C-w>k")

vim.keymap.set('n', '<C-l>', "<C-w>l")


-- visual reselect after indenting

vim.keymap.set('v', '<', "<gv")

vim.keymap.set('v', '>', ">gv")


-- save file

vim.keymap.set('n', '<C-S>', "<cmd>:update<CR>")


-- move line of text down

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- move line of text up

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- bring line of text below, up, but keep cursor in position

vim.keymap.set("n", "J", "mzJ`z")

-- don't lose your copied text while pasting

vim.keymap.set("x", "<leader>p", [["_dP]])


-- ----------------------------------------------------------------------------
-- Lazy.nvim (package manager)
-- ----------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Color Theme
  {
    -- package name
    'athomasoriginal/vim-alabaster',
    -- load during startup
    lazy = false,
    -- load before other plugins
    priority = 1000,
    -- run colorscheme
    config = function ()
      vim.cmd([[colorscheme alabaster-dark]])
    end,
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim'
    }
  },

  -- Telescope Extension - Projects
  'nvim-telescope/telescope-project.nvim',

  -- Pretty Icons
  'kyazdani42/nvim-web-devicons',

  -- Markdown Tooling
  'plasticboy/vim-markdown',

  -- Lsp
  'neovim/nvim-lspconfig',

  -- Commenting
  'preservim/nerdcommenter',

  -- Folder/File GUI
  'preservim/nerdtree',

  -- Clojure - structural formatting
  {
    'eraserhd/parinfer-rust',
    ft = "clojure",
    build = 'cargo build --release'
  },

  -- Clojure - structural formatting
  {
    'guns/vim-sexp',
    ft = "clojure"
  },

  -- Clojure - integrated REPL
  {
    'liquidz/vim-iced',
    ft = "clojure"
  },

  -- Kitty - Syntax Highlighting Support
  "fladson/vim-kitty",

  -- JavaScript - formatting
  {
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {'javascript', 'markdown', 'css', 'json', 'html'}
  }
})


-- ----------------------------------------------------------------------------
-- Telescope Config
-- ----------------------------------------------------------------------------
-- vimgrep_arguments -> used by live_grep and live_search
-- find_files        -> is a builtin which projects calls under the hood --

local telescope = require('telescope')

telescope.setup {
  defaults = {
    file_sorter          = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix        = " >",
    color_devicons       = true,
    file_ignore_patterns = { "node_modules", ".git", "target/.*", ".cpcache" },

    -- https://www.mankier.com/1/rg#--files-with-matches
    -- search_dirs = { "$HOME/code/projects" },
    file_previwer        = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer       = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer     = require("telescope.previewers").vim_buffer_qflist.new,
  },
  pickers = {
    find_files = {
      find_command = {'rg', '--files', '-L', '--hidden'},
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}


telescope.load_extension("project")
telescope.load_extension("fzy_native")


-- ----------------------------------------------------------------------------
-- Treesitter
-- ----------------------------------------------------------------------------
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
  ensure_installed = {
    "c",
    "html",
    "css",
    "vim",
    "lua",
    "javascript",
    "clojure",
    "rust",
    "markdown",
    "markdown_inline"
  },
}

-- ----------------------------------------------------------------------------
-- LSP Config
-- ----------------------------------------------------------------------------

local nvim_lsp = require('lspconfig')


local server_settings = {
  ccls        = {},
  clojure_lsp = {
    ['semantic-tokens?'] = true,
  }
}


local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)

  -- navigate to definition in current buffer
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- navigate to definition in new buffer + side-by-side for context
  buf_set_keymap('n', 'gv', '<cmd>:vsplit | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.setloclist()<CR>', opts)
end


---- Start
---- Loop through all servers conveniently and apply local bindings, settings
---- etc the the servers
local servers = { 'ccls', 'clojure_lsp' }

for _, lsp in ipairs(servers) do
  -- Global LSP Options to be aplied to all lsp servers
  local lsp_opts = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    init_options = {}
  }

  -- LSP Specific Settings to apply
  if server_settings[lsp] then
    lsp_opts.init_options = server_settings[lsp]
  end

  -- Start LSP Server
  nvim_lsp[lsp].setup(lsp_opts)
end

-- ----------------------------------------------------------------------------
-- lasticboy/vim-markdown
-- ----------------------------------------------------------------------------

-- syntax highlight contents of code blocks in md files

vim.g.markdown_fenced_languages = {
  'html',
  'javascript',
  'command=bash',
  'bash',
  'vim',
  'clojure',
  'njk'
}

vim.g.markdown_flavor = 'github'

vim.g.vim_markdown_folding_disabled = 1


-- ----------------------------------------------------------------------------
-- guns/vim-sexp
-- ----------------------------------------------------------------------------

vim.g.sexp_enable_insert_mode_mappings = 0

-- ----------------------------------------------------------------------------
-- guns/vim-sexp
-- ----------------------------------------------------------------------------

vim.g.iced_enable_default_key_mappings = true

-- ----------------------------------------------------------------------------
-- liquidz/vim-iced
-- ----------------------------------------------------------------------------

vim.g.NERDTreeShowHidden = 1

-- ----------------------------------------------------------------------------
-- autocommandgroups
-- ----------------------------------------------------------------------------
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})
