return {
    packages = function(use)
        use({
            "nvim-neotest/neotest",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-treesitter/nvim-treesitter",
                "antoinemadec/FixCursorHold.nvim",
                "haydenmeade/neotest-jest",
                "nvim-neotest/neotest-python",
                "rouge8/neotest-rust",
                "sidlatau/neotest-dart",
            },
        })
    end,
    setup = function()
        require("neotest").setup({
            adapters = {
                require("neotest-python"),
                require("neotest-rust"),
                require("neotest-jest")({
                    jestCommand = "npm test --",
                    jestConfigFile = "custom.jest.config.ts",
                    env = { CI = true },
                    cwd = function(path)
                        return vim.fn.getcwd()
                    end,
                }),
                require('neotest-dart') {
                    -- change it to `dart` for Dart only tests
                    command = 'flutter',
                },
            },
        })
    end,
    keybindings = function(bindkey)
        bindkey("", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>")
        bindkey("", "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>")
        bindkey("", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>")
        bindkey("", "<leader>ts", "<cmd>lua require('neotest').summary.open()<cr>")
    end,
}
