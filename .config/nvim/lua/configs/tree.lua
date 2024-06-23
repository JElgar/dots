local function locate_file()
	local api = require "nvim-tree.api"
	local file_path = vim.api.nvim_buf_get_name(0)

	api.tree.open()
	api.tree.find_file(file_path)
end

return {
	'kyazdani42/nvim-tree.lua',
	dependencies = {
		'kyazdani42/nvim-web-devicons', -- optional, for file icons
	},
	init = function()
		require("nvim-tree").setup({
			filters = {
				dotfiles = true,
			},
		})
	end,
	keys = {
		{ "<leader>fl", locate_file, mode = "n" },
		{ "<leader>fd", "<cmd>NvimTreeToggle<Enter>", mode = "n" },
	},
}
