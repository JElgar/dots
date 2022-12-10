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
	end,
	keybindings = function (bindkey)
		bindkey("n", "<leader>fd", "<cmd>NvimTreeToggle<Enter>")
	end,
}
