return {
	packages = function(use)
		use "tpope/vim-fugitive"
		use "lewis6991/gitsigns.nvim"
		use {
			"NeogitOrg/neogit",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"sindrets/diffview.nvim",
				"nvim-telescope/telescope.nvim",
			},
		}
	end,
	setup = function()
		require('gitsigns').setup()
		require('neogit').setup()
	end,
	keybindings = function (bindkey)
	end,
}
