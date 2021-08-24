-- Telescope Config

-- vimgrep_arguments >> used by live_grep and live_search
-- find_files is a builtin which projects calls under the hood --

-- none of this stuff seems to be being picked up
require('telescope').setup {
  defaults = {
    file_sorter          = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix        = " >",
    color_devicons       = true,
    file_ignore_patterns = { "node_modules", ".git" },
    -- https://www.mankier.com/1/rg#--files-with-matches
    -- search_dirs = { "$HOME/code/projects" },

    file_previwer        = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer       = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer     = require("telescope.previewers").vim_buffer_qflist.new,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

require("telescope").load_extension("project")
require("telescope").load_extension("fzy_native")
require("nvim-treesitter.configs").setup { highlight = { enable = true } }
