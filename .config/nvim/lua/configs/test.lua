return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- Language specific dependencies
      "haydenmeade/neotest-jest",
      "nvim-neotest/neotest-python",
      "rouge8/neotest-rust",
      "sidlatau/neotest-dart",
    },
    keys = {
      { "<leader>tr", function() require('neotest').run.run() end, mode = "n" },
      { "<leader>td", function() require('neotest').run.run({strategy = 'dap'}) end, mode = "n" },
      { "<leader>tf", function() require('neotest').run.run(vim.fn.expand('%')) end, mode = "n" },
      { "<leader>ts", function() require('neotest').summary.open() end, mode = "n" },
    },
    init = function ()
      require("neotest").setup({
        adapters = {
          require("neotest-python"),
          -- Requires installing nextest https://nexte.st/docs/installation/from-source/
          require("neotest-rust"),
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
          }),
          require('neotest-dart') {
            -- change it to `dart` for Dart only tests
            command = 'flutter',
            use_lsp = true,
          },
        },
      })
    end
  }
}
