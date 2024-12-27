function setThemeDark()
	vim.o.background = "dark" -- or "light" for light mode
	vim.cmd([[colorscheme gruvbox]])
end

function setThemeLight()
	vim.o.background = "light" -- or "light" for light mode
	vim.cmd([[colorscheme catppuccin]])
end

function setThemeZen()
	vim.o.background = "dark" -- or "light" for light mode
	vim.cmd([[colorscheme catppuccin-macchiato]])
end

vim.api.nvim_create_user_command(
	'SetThemeDark',
	setThemeDark,
	{ nargs = 0, desc = 'Enable dark theme' }
)

vim.api.nvim_create_user_command(
	'SetThemeLight',
	setThemeLight,
	{ nargs = 0, desc = 'Enable light theme' }
)

return {
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		priority = 1000,
		init = function()
			setThemeDark()
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"norcalli/nvim-colorizer.lua",
		init = function()
			require 'colorizer'.setup()
		end,
	},
}
