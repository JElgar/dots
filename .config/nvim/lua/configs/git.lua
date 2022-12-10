return {
	packages = function(use)
		use "tpope/vim-fugitive"
        use "lewis6991/gitsigns.nvim"
	end,
	setup = function()
        require('gitsigns').setup()
	end,
	keybindings = function (bindkey)
	end,
}
