local lsp = require("configs.lsp")

return {
	packages = function(use)
		use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
	end,
	setup = function()
		require("flutter-tools").setup({
            flutter_path = "/Users/jnelgar/Documents/dev/flutter/bin/flutter",
			lsp = {
				on_attach = lsp.on_attach
			}
		})
	end,
}
