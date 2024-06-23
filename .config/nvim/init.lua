vim.g.mapleader = ' '
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('', '<Space>', '<Nop>')

local function keymap(mode, key, command)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap(mode, key, command, opts)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- Extra dependencies
	-- TMUX navigation
	import = 'configs',
})

vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Tabs
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.opt.list = true
