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
-- * Report a setting's value
--   `:set shiftwidth?`
-- * Report where a setting was set
--   `:verbose set shiftwidth?`

-- ----------------------------------------------------------------------------
-- Options
-- ----------------------------------------------------------------------------

-- Text
-- ----------------------------------------------------------------------------
vim.opt.wrap = false       -- Don't automatically wrap text
vim.opt.scrolloff = 8      -- Keep 10 char visible above and below cursor
vim.opt.sidescrolloff = 8  -- Keep 20 char visible right and left of cursor
vim.opt.colorcolumn = "80" -- Add a vertical bar at 80 characters


-- General
-- ----------------------------------------------------------------------------
vim.opt.errorbells = true  -- prevent bell noise when things go wrong
vim.opt.title = true       -- show window title
vim.opt.titlestring = "NVIM - %t" -- Set the terminal tab title
vim.opt.hidden = true      -- hide the buffers in the background (don't close em)
vim.opt.swapfile = false   -- remove swapfiles (they're annoying)
vim.opt.backup = false     -- remove swapfiles (they're annoying)
vim.opt.splitright = true  -- default to splitting windows to the right
vim.opt.number = true      -- Show line numbers
vim.opt.signcolumn = "yes" -- Add space to the left column (for signs like git)


-- Clipboard
-- ----------------------------------------------------------------------------
vim.opt.clipboard:append("unnamedplus") -- user system clipboard as default reg


-- Tab & Indentation Formatting
-- ----------------------------------------------------------------------------
vim.opt.shiftwidth = 2     -- number of spaces to use when indententing
vim.opt.softtabstop = 2    -- number of spaces to insert when the tab pressed
vim.opt.tabstop = 2        -- number of spaces existing tabs are visualized
vim.opt.expandtab = true   -- When tab pressed, insert ` ` instead of `\t` char
vim.opt.smartindent = true -- Copy the indent from the current line to the next
vim.opt.formatoptions = vim.opt.formatoptions
	- 'a' -- avoid auto formatting
	- 't' -- avoid auto formating code
	+ 'c' -- comments respect textwidth
	+ 'q' -- Allow formatting comments w/ gq
	- 'o' -- O and o don't continue comments
	+ 'r' -- continue comments when pressing enter.
	+ 'n' -- Indent past the formatlistpat, not underneath it.
	+ 'j' -- Auto-remove comments if possible.
--vim.opt.formatlistpat = "^\\s*\\d\\+[\\]:.)}\\t ]\\s*"


-- Search Settings
-- ----------------------------------------------------------------------------
vim.opt.ignorecase = true  -- Ignore case when searching
vim.opt.smartcase  = true  -- Mix cases to activate case sensitive search
vim.opt.incsearch  = true  -- Search as we type


-- Statusline
-- ----------------------------------------------------------------------------
vim.opt.laststatus = 3  -- set statusline to be global status line
vim.opt.showmode = true -- Hide the mode you're currently in (status bar)


-- Colors
-- ----------------------------------------------------------------------------
vim.opt.termguicolors = true           -- Use colorschemes you set
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1 -- True Color Support


-- Mouse Enhancement - Kitty
-- ----------------------------------------------------------------------------

vim.opt.mouse = "a"          -- Mouse Support - prevent copying line numbers
                             -- when using a mouse


-- ----------------------------------------------------------------------------
-- Remaps
-- ----------------------------------------------------------------------------

-- press space for glory - should be before lazy.nvim
-- ----------------------------------------------------------------------------
vim.g.mapleader = " "


-- escape shortcut
-- ----------------------------------------------------------------------------
vim.keymap.set('i', 'jk', "<ESC>")


-- folder/file navigation
-- ----------------------------------------------------------------------------
vim.keymap.set('n', '<leader>n', "<cmd>NERDTreeToggle<CR>")

vim.keymap.set('n', '<leader>p', "<cmd>Telescope project<CR>")

vim.keymap.set('n', '<leader>f', "<cmd>Telescope find_files<CR>")

vim.keymap.set('n', '<leader>b', "<cmd>Telescope buffers<CR>")

--vim.keymap.set('n', '<leader>g', "<cmd>Telescope live_grep<CR>")

vim.keymap.set('n', '<leader>g', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

vim.keymap.set('n', '<leader>dl', "<cmd>edit ~/code/dev-log.md<CR>")


-- remove active highlights
-- ----------------------------------------------------------------------------
vim.keymap.set('n', '<leader>k', "<cmd>nohlsearch<CR>")


-- window navigation
-- ----------------------------------------------------------------------------
vim.keymap.set('n', '<C-h>', "<C-w>h")

vim.keymap.set('n', '<C-j>', "<C-w>j")

vim.keymap.set('n', '<C-k>', "<C-w>k")

vim.keymap.set('n', '<C-l>', "<C-w>l")


-- visual reselect after indenting
-- ----------------------------------------------------------------------------
vim.keymap.set('v', '<', "<gv")

vim.keymap.set('v', '>', ">gv")


-- save file
-- ----------------------------------------------------------------------------
vim.keymap.set('n', '<C-S>', "<cmd>:update<CR>")


-- move line of text down
-- ----------------------------------------------------------------------------
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")


-- move line of text up
-- ----------------------------------------------------------------------------
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- bring line of text below, up, but keep cursor in position
-- ----------------------------------------------------------------------------
vim.keymap.set("n", "J", "mzJ`z")


-- don't lose your copied text while pasting
-- ----------------------------------------------------------------------------
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move to start/end of line
-- ----------------------------------------------------------------------------
vim.keymap.set({ "n", "x", "o" }, "H", "^", opts)

vim.keymap.set({ "n", "x", "o" }, "L", "g_", opts)


-- ----------------------------------------------------------------------------
-- Package Manager (Lazy.nvim)
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
  -- Color Theme & Styles
  -- --------------------------------------------------------------------------

  -- Custome color theme
  {
    'athomasoriginal/vim-alabaster',
    lazy = false,                    -- load during startup
    priority = 1000,                 -- load before other plugins
    config = function ()             -- run colorscheme
      vim.cmd([[colorscheme alabaster-dark]])
    end,
  },

  -- Pretty icons
  'kyazdani42/nvim-web-devicons',

  -- Kitty - Syntax Highlighting Support
  "fladson/vim-kitty",

  -- Jai Syntax Highlighting
  "rluba/jai.vim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event  = { "BufReadPre", "BufNewFile" },
    build  = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter.configs")

      treesitter.setup({
        highlight = {
          enable = true,
        },
        ensure_installed = {
          "c",
          "html",
          "css",
          "vim",
          "lua",
          "json",
          "javascript",
          "clojure",
          "rust",
          "markdown",
          "markdown_inline",
        },
      })
    end,
  },

  -- File Search & Navigation
  -- --------------------------------------------------------------------------

  -- Search files/folders
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-telescope/telescope-live-grep-args.nvim',
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', build = "make" },
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()

    end
  },

  -- Telescope extension projects
  'nvim-telescope/telescope-project.nvim',

  -- File/Folder UI
  'preservim/nerdtree',


  -- Language Support
  -- --------------------------------------------------------------------------
  -- LSP
  'neovim/nvim-lspconfig',

  -- Clojure - auto structural editing
  {
    'eraserhd/parinfer-rust',
    ft = "clojure",
    build = 'cargo build --release'
  },

  -- Clojure - manual structural editing
  {
    'guns/vim-sexp',
    ft = "clojure"
  },

  -- Clojure - integrated repl
  --{
    --'liquidz/elin',
    --ft = "clojure"
  --},

  {
    "Olical/conjure"
  },


  -- Convenience
  -- --------------------------------------------------------------------------

  -- Commenting
  'preservim/nerdcommenter',

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
-- find_files        -> is a builtin which projects calls under the hood

local telescope = require('telescope')

telescope.setup {
  defaults = {
    file_sorter          = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix        = " >",
    color_devicons       = true,
    file_ignore_patterns = { -- js
                             "node_modules",
                             -- general
                             ".git",
                             -- clojure
                             "target/.*",
                             ".cpcache/",
                             ".clj%-kondo/"},

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
telescope.load_extension("live_grep_args")


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

-- @note nvim disables these by default since 0.11.0
vim.diagnostic.config({
  virtual_text = true,  -- show inline messages
  signs = true,         -- show signs in the gutter
  update_in_insert = false, -- don't update diagnostics while typing
})

-- ----------------------------------------------------------------------------
-- guns/vim-sexp
-- ----------------------------------------------------------------------------

vim.g.sexp_enable_insert_mode_mappings = 0

-- ----------------------------------------------------------------------------
-- Clojure REPL Keymappings
--
-- liquidz/elin is still here for reference.
--
-- https://github.com/liquidz/elin/blob/ad692d01275500e479252a4c964d36c73b3064f8/plugin/elin.vim
-- The above is a useful file to reference configurations
-- ----------------------------------------------------------------------------

--vim.keymap.set("n", "<leader>'", "<cmd>ElinConnect<CR>")
--vim.keymap.set("n", "<leader>ss", "<cmd>ElinToggleInfoBuffer<CR>")
--vim.keymap.set("n", "<leader>ep", "<cmd>ElinPrintLastResult<CR>")
--vim.keymap.set("n", "<leader>ee", "<cmd>ElinEvalCurrentList<CR>")
---- @note command chosen because in my head it's like "evaluate test"
--vim.keymap.set("n", "<leader>et", "<cmd>ElinTestFocusedCurrentTesting<CR>")
---- @note command chosen because `r` is closer than `t`
--vim.keymap.set("n", "<leader>er", "<cmd>ElinEvalCurrentTopList<CR>")
--vim.g.elin_debug = true;
--vim.g.elin_server_port = 51255;
--vim.g.elin_server_auto_connect = true;

vim.g["conjure#mapping#disable_defaults"] = true;

vim.keymap.set('n', '<leader>ee', '<Cmd>ConjureEval<CR>')
vim.keymap.set('v', '<leader>ee', '<Cmd>ConjureEval<CR>')
vim.keymap.set('n', '<leader>er', '<Cmd>ConjureEvalRootForm<CR>')
vim.keymap.set('n', '<leader>ew', '<Cmd>ConjureEvalWord<CR>')
vim.keymap.set('n', '<leader>eb', '<Cmd>ConjureEvalBuffer<CR>')
vim.keymap.set('n', '<leader>ls', '<Cmd>ConjureLogVSplit<CR>')
vim.keymap.set('n', '<leader>lc', '<Cmd>ConjureLogClose<CR>')

-- ----------------------------------------------------------------------------
-- preservim/nerdtree
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

-- ----------------------------------------------------------------------------
-- markdown
-- ----------------------------------------------------------------------------

-- remove vim's default options
vim.g.markdown_recommended_style = 0

