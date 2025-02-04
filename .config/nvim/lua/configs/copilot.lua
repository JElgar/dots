return {
        {
                'Exafunction/codeium.vim',
                init = function()
                        vim.g.codeium_disable_bindings = 1
                        vim.keymap.set('i', '<C-l>', function() return vim.fn['codeium#Accept']() end, { expr = true })
                        vim.keymap.set('i', '<c-h>', function() return vim.fn['codeium#CycleCompletions'](1) end,
                                { expr = true })
                        vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true })
                end,
                enabled=false,
        }
}
