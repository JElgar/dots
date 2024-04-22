return {
	packages = function(use)
		use {
  			'kyazdani42/nvim-tree.lua',
  			requires = {
  				'kyazdani42/nvim-web-devicons', -- optional, for file icons
  			},
		}
	end,
	setup = function()
		require("nvim-tree").setup({
            filters = {
                dotfiles = true,
            },
        })

		local function locate_file()
			local api = require "nvim-tree.api"
			local file_path = vim.api.nvim_buf_get_name(0)

			api.tree.open()
			api.tree.find_file(file_path)
		end

		vim.keymap.set("n", "<leader>fl", locate_file, { noremap = true })
	end,
	keybindings = function (bindkey)
		bindkey("n", "<leader>fd", "<cmd>NvimTreeToggle<Enter>")
	end,
}
