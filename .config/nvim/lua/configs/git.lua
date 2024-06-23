return {
	"tpope/vim-fugitive",
	"lewis6991/gitsigns.nvim",
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	init = function()
		require('gitsigns').setup()
		require('neogit').setup()
	end,
}
