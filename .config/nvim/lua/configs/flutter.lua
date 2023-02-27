local lsp = require("configs.lsp")

return {
	packages = function(use)
		use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
	end,
	setup = function()
		require("flutter-tools").setup({
            flutter_path = "/home/jelgar/snap/flutter/common/flutter/bin/flutter",
			lsp = {
				on_attach = lsp.on_attach
			}
		})
	end,
}
