vim.g.mapleader = ' '

local function keymap(mode, key, command)
	local opts = {noremap = true, silent = true}
	vim.api.nvim_set_keymap(mode, key, command, opts)
end

local packer_bootstrap = require('packer-setup').setup()

-- A config returns a packages and setup function 
local configs = {'configs.lsp', 'configs.tree', 'configs.theme', 'configs.telescope', 'configs.flutter', 'configs.dap', 'configs.test'}

require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	
	-- Setup all the configs
	for _, config in pairs(configs) do
		local mod = require(config)
		if not mod then
			print(config .. ' config not found')
		end
		if mod.packages then
			mod.packages(use)
		end
		if mod.setup then
			mod.setup()
		end
		if mod.keybindings then
			mod.keybindings(keymap)
		end
	end

	-- Extra dependencies
	-- TMUX navigation
	use 'christoomey/vim-tmux-navigator'
	
	if packer_bootstrap then
    		require('packer').sync()
  	end
end)

keymap('i', 'jk', '<ESC>')
keymap('', '<Space>', '<Nop>')
keymap('', '<C-e>', '<C-w>')

vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
