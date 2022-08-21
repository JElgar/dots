-- A collection of utilities

return {
    packages = function(use)
        use({
            "kylechui/nvim-surround",
            tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        })

    end,
    setup = function()
        require("nvim-surround").setup({
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "<leader>sa",
                normal_cur = "<leader>sac",
                normal_line = "<leader>sA",
                normal_cur_line = "<leader>sAc",
                visual = "<leader>sa",
                visual_line = "<leader>sA",
                delete = "<leader>sd",
                change = "<leader>sc",
            },
        })
    end,
    keybindings = function(bindkey)
    end,
}
