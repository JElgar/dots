return {
	packages = function(use)
        -- use "github/copilot.vim"
        use 'Exafunction/codeium.vim'
	end,
	setup = function()
	end,
	keybindings = function (bindkey)
        vim.g.codeium_disable_bindings = 1
        vim.keymap.set('i', '<C-l>', function () return vim.fn['codeium#Accept']() end, { expr = true })
        vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
	end,
}
