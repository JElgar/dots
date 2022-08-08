local lsp = require("configs.lsp")

return {
	packages = function(use)
		use {'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim'}
	end,
	setup = function()
		require("flutter-tools").setup({
			lsp = {
				on_attach = lsp.on_attach
			}
		})
	end,
}
