return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		init = function()
			local dap = require("dap")
			local ui = require("dapui")

			ui.setup()
			require("nvim-dap-virtual-text").setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				ui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				ui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				ui.close()
			end
		end,
		keys = {
			{ "<leader>do", function() require('dapui').open() end,                    mode = "" },
			{ "<leader>dq", function() require('dapui').close() end,                   mode = "" },
			{ "<leader>dc", function() require('dap').continue() end,                  mode = "" },
			{ "<leader>db", function() require('dap').toggle_breakpoint() end,         mode = "" },
			{ "<leader>dg", function() require('dap').run_to_cursor() end,             mode = "" },
			{ "<leader>ds", function() require('dap').step_over() end,                 mode = "" },
			{ "<leader>di", function() require('dap').step_into() end,                 mode = "" },
			{ "<leader>de", function() require('dapui').eval(nil, { enter = true }) end, mode = "" },
		}
	}
}

-- return {
--     packages = function(use)
--         use {
--             'mfussenegger/nvim-dap',
--             { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
--         }
--
--         -- There is currently no support for vscode-js-debug in Mason, once
--         -- there is this should no longer be required.
--         use {
--             "microsoft/vscode-js-debug",
--             opt = true,
--             run = "npm install --legacy-peer-deps && npm run compile"
--         }
--         use { "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } }
--     end,
--     setup = function()
--         local mason_registry = require("mason-registry")
--         local debugpy = mason_registry.get_package("debugpy")
--
--         local dap = require('dap')
--
--         -- Python dap
--         dap.adapters.python = {
--             type = 'executable',
--             command = debugpy:get_install_path() .. "/debugpy-adapter",
--         }
--         dap.configurations.python = {
--             {
--                 type = 'python';
--                 request = 'launch';
--                 name = "Launch file";
--                 program = "${file}";
--                 pythonPath = function()
--                     return '/bin/python'
--                 end;
--             },
--         }
--
--         -- Js dap
--         require("dap-vscode-js").setup({
--             -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--             -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
--             adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
--         })
--         for _, language in ipairs({ "typescript", "javascript" }) do
--             require("dap").configurations[language] = {
--                 {
--                     type = "pwa-node",
--                     request = "launch",
--                     name = "Launch file",
--                     program = "${file}",
--                     cwd = "${workspaceFolder}",
--                 },
--                 {
--                     type = "pwa-node",
--                     request = "attach",
--                     name = "Attach",
--                     processId = require 'dap.utils'.pick_process,
--                     cwd = "${workspaceFolder}",
--                 }
--             }
--         end
--
--         local dapui = require('dapui')
--         dapui.setup()
--
--         dap.listeners.after.event_initialized["dapui_config"] = function()
--             dapui.open()
--         end
--         dap.listeners.before.event_terminated["dapui_config"] = function()
--             dapui.close()
--         end
--         dap.listeners.before.event_exited["dapui_config"] = function()
--             dapui.close()
--         end
--     end,
--     keybindings = function(bindkey)
--         bindkey("", "<leader>do", "<cmd>lua require('dapui').open()<cr>")
--         bindkey("", "<leader>dq", "<cmd>lua require('dapui').close()<cr>")
--         bindkey("", "<leader>dc", "<cmd>DapContinue<cr>")
--         bindkey("", "<leader>db", "<cmd>DapToggleBreakpoint<cr>")
--         bindkey("", "<leader>dso", "<cmd>lua require('dap').step_over()<cr>")
--         bindkey("", "<leader>dsi", "<cmd>lua require('dap').step_into()<cr>")
--         bindkey("", "<leader>de", "<cmd>lua require('dapui').eval()<cr>")
--     end,
-- }
