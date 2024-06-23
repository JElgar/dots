return {
	"ellisonleao/gruvbox.nvim",
	init = function()
		-- Colors
		vim.o.background = "dark" -- or "light" for light mode
		vim.cmd([[colorscheme gruvbox]])

		-- Line numbers
		vim.o.relativenumber = true
		vim.o.number = true
	end,
}
