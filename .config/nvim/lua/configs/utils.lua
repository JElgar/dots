-- A collection of utilities

return {
    {
        "kylechui/nvim-surround",
        tag = "*",     -- Use for stability; omit to use `main` branch for the latest features
        init = function()
            require("nvim-surround").setup{
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
            }
        end,
    },
    "tpope/vim-sleuth",
}
