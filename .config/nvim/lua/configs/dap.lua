function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.dap_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end

return {
	packages = function(use)
		use {
			'mfussenegger/nvim-dap',
			{ "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
		}
	end,
	setup = function()
		local mason_registry = require("mason-registry")
		local debugpy = mason_registry.get_package("debugpy")

		local dap = require('dap')
		dap.adapters.python = {
    	  type = 'executable';
    	  command = debugpy:get_install_path() .. "/debugpy-adapter";
    	}
		dap.configurations.python = {
    	  {
    	    type = 'python';
    	    request = 'launch';
    	    name = "Launch file";
    	    program = "${file}";
    	    pythonPath = function()
    	      return '/bin/python'
    	    end;
    	  },
    	}

		local dapui = require('dapui')
		dapui.setup()

		dap.listeners.after.event_initialized["dapui_config"] = function()
		  dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
		  dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
		  dapui.close()
		end
	end,
	keybindings = function (bindkey)
		bindkey("", "<leader>do", "<cmd>lua require('dapui').open()<cr>")
		bindkey("", "<leader>dq", "<cmd>lua require('dapui').close()<cr>")
		bindkey("", "<leader>dc", "<cmd>DapContinue<cr>")
		bindkey("", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
		bindkey("", "<leader>ds", "<cmd>DapStepInto<cr>")
		bindkey("", "<leader>de", "<cmd>lua require('dapui').eval()<cr>")
	end,
}
