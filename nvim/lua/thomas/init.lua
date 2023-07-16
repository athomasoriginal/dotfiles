-- ----------------------------------------------------------------------------
-- Sets
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

-- prevent copying of line numbers when using a mouse
vim.opt.mouse = "a"

-- prevent bell noise when things go wrong
vim.opt.errorbells = true

vim.opt.title = true

-- remove swapfiles - annoying
vim.opt.swapfile = false
vim.opt.backup = false

-- infinite horizontal typing
vim.opt.wrap = true

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

-- 
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- ----------------------------------------------------------------------------
-- Remaps
-- ----------------------------------------------------------------------------

-- press space for glory

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


-- ----------------------------------------------------------------------------
-- Packer
-- ----------------------------------------------------------------------------

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

require('packer').startup(function(use)
  -- Packer can manage itself

  use 'wbthomason/packer.nvim'

  -- Telescope

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'nvim-telescope/telescope-project.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Treesitter

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }
  use 'nvim-treesitter/playground'

  -- Color Theme

  use{
    'athomasoriginal/vim-alabaster',
    as = 'alabaster-dark',

    config = function()
      vim.cmd('colorscheme alabaster-dark')
    end
  }

  -- Pretty Icons
  
  use 'kyazdani42/nvim-web-devicons'

  -- Markdown Tooling
  
  use 'plasticboy/vim-markdown'

  -- Lsp
  
  use 'neovim/nvim-lspconfig'

  -- Commenting
  
  use 'preservim/nerdcommenter'

  -- Folder/File GUI
  
  use 'preservim/nerdtree'

  -- Clojure

  use {
    'eraserhd/parinfer-rust', 
    ft = "clojure", 
    run = 'cargo build --release'
  }

  use { 
    'guns/vim-sexp', 
    ft = "clojure"
  }

  use {
    'liquidz/vim-iced', 
    ft = "clojure"
  }

  -- formatting

  use { 
    'prettier/vim-prettier',
    run = 'yarn install',
    ft = {'javascript', 'markdown', 'css', 'json', 'html'} 
  }
end)

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

---- --------------------------------------------------------------------------
---- LSP Config
---- --------------------------------------------------------------------------

local nvim_lsp = require('lspconfig')


local server_settings = {
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
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>zp', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

end


---- Start
---- Loop through all servers conveniently and apply local bindings, settings
---- etc the the servers
local servers = { 'clojure_lsp' }

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


---- --------------------------------------------------------------------------
---- lasticboy/vim-markdown
---- --------------------------------------------------------------------------

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


---- --------------------------------------------------------------------------
---- guns/vim-sexp
---- --------------------------------------------------------------------------

vim.g.sexp_enable_insert_mode_mappings = 0

---- --------------------------------------------------------------------------
---- preservim/nerdtree
---- --------------------------------------------------------------------------

vim.g.NERDTreeShowHidden = 1


---- --------------------------------------------------------------------------
---- autocommandgroups
---- --------------------------------------------------------------------------
local TrimWhiteSpaceGrp = vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})
