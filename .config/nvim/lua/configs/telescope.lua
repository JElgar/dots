local _, telescope = pcall(require, "telescope")

local default = {
   defaults = {
      vimgrep_arguments = {
         "rg",
         "--color=never",
         "--no-heading",
         "--with-filename",
         "--line-number",
         "--column",
         "--smart-case",
      },
      mappings = {
         i = {
            ["jk"] = require('telescope.actions').close,
         },
      },
      prompt_prefix = " 🔭 ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
         horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
         },
         vertical = {
            mirror = false,
         },
         width = 0.87,
         height = 0.80,
         preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
   },
}

local function setup()
   	require("telescope").setup(default)

   	local extensions = { "themes", "terms" }

   	pcall(function()
   	   for _, ext in ipairs(extensions) do
   	      telescope.load_extension(ext)
   	   end
   	end)
end

local function keybindings (bindkey)
	bindkey("n", "gr", "<cmd> Telescope lsp_references<cr>")
   	bindkey("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>")
	bindkey("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
	bindkey("n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>")
	bindkey("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
	bindkey("n", "<leader>fc", "<cmd>lua require('telescope.actions').close()<cr>")
end

return {
	packages = function(use)
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
  			requires = { 'nvim-lua/plenary.nvim' }
		}
	end,
	setup = setup,
	keybindings = keybindings,
}
