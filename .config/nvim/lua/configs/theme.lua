local function setup()
	vim.o.background = "dark" -- or "light" for light mode
	vim.cmd([[colorscheme gruvbox]])
end

return {
	packages = function(use)
		use "ellisonleao/gruvbox.nvim"
	end,
	setup = setup,
}
