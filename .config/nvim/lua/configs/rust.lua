local lsp = require("configs.lsp")

return {
	packages = function(use)
		use 'simrat39/rust-tools.nvim'
	end,
	setup = function()
		local rt = require("rust-tools")

		rt.setup({
		  server = {
		    on_attach = function(client, bufnr)
			  lsp.on_attach(client, bufnr)

		      -- Hover actions
		      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
		      -- Code action groups
		      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
		      vim.keymap.set("n", "<Leader>z", rt.expand_macro.expand_macro, { buffer = bufnr })
		    end,
		  },
		})
	end,
}
