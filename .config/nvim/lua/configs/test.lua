return {
	packages = function(use)
		use 'vim-test/vim-test'
		use {
			"nvim-neotest/neotest",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-plenary",
			"rouge8/neotest-rust",
			requires = {
				"nvim-lua/plenary.nvim",
		    	"nvim-treesitter/nvim-treesitter",
		    	"antoinemadec/FixCursorHold.nvim"
			}
		}
	end,
	setup = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = false },
		    	}),
				require("neotest-plenary"),
				require("neotest-rust")
			},
		})

		local adapters = neotest.run.adapters()
		for a in pairs(adapters) do
			print(a)
		end

		local count = 0
		for _ in pairs(adapters) do count = count + 1 end
		print(count)
	end,
	keybindings = function (bindkey)
	end,
}
