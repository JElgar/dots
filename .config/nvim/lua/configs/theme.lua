local function setup()
	-- Colors
	vim.o.background = "dark" -- or "light" for light mode
	vim.cmd([[colorscheme gruvbox]])

	-- Line numbers 
	vim.o.relativenumber = true
	vim.o.number = true
end

return {
	packages = function(use)
		use "ellisonleao/gruvbox.nvim"
	end,
	setup = setup,
}
