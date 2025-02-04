-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true }
	local args = {}
	local function map_key(mode, key, command) vim.keymap.set(mode, key, command, opts) end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map_key('n', 'gD', vim.lsp.buf.declaration)
	map_key('n', 'gd', vim.lsp.buf.definition)
	map_key('n', 'K', vim.lsp.buf.hover)
	map_key('n', 'gi', vim.lsp.buf.implementation)
	map_key('n', '<C-k>', vim.lsp.buf.signature_help)
	map_key('n', '<space>wa', vim.lsp.buf.add_workspace_folder)
	map_key('n', '<space>wr', vim.lsp.buf.remove_workspace_folder)
	map_key('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end)
	map_key('n', '<space>D', vim.lsp.buf.type_definition)
	map_key('n', '<space>rn', vim.lsp.buf.rename)
	map_key('n', '<space>ca', vim.lsp.buf.code_action)
	map_key('n', ',f', function()
		vim.lsp.buf.format { async = true }
	end)

	-- Language Specific
	client.server_capabilities.document_formatting = true
end

local function setup_cmp()
	-- Setup nvim-cmp (auto complete)
	local cmp = require 'cmp'

	cmp.setup({
		snippet = {
			expand = function(args)
				-- For `vsnip` user.
				vim.fn['vsnip#anonymous'](args.body)

				-- For `luasnip` user.
				-- require('luasnip').lsp_expand(args.body)

				-- For `ultisnips` user.
				-- vim.fn["UltiSnips#Anon"](args.body)
			end,
		},
		mapping = {
			['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.close(),
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
			['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
		},
		sources = {
			{ name = 'nvim_lsp' },

			-- For vsnip user.
			{ name = 'vsnip' },

			-- For luasnip user.
			-- { name = 'luasnip' },

			-- For ultisnips user.
			-- { name = 'ultisnips' },

			{ name = 'buffer' },
		}
	})
end

local function make_config(server_name)
	-- Setup base config for each server.
	local c = {}
	c.on_attach = on_attach
	local cap = vim.lsp.protocol.make_client_capabilities()
	c.capabilities = require('cmp_nvim_lsp').default_capabilities(cap)

	-- Merge user-defined lsp settings.
	-- These can be overridden locally by lua/lsp-local/<server_name>.lua
	local exists, module = pcall(require, 'lsp-local.' .. server_name)
	if not exists then
		exists, module = pcall(require, 'lsp.' .. server_name)
	end
	if exists then
		local user_config = module.config(c)
		for k, v in pairs(user_config) do c[k] = v end
	end

	return c
end

local function setupAmazon()
	bemol = function()
		local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory' })[1]
		local ws_folders_lsp = {}
		if bemol_dir then
			local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
			if file then
				for line in file:lines() do
					table.insert(ws_folders_lsp, line)
				end
				file:close()
			end
		end

		for _, line in ipairs(ws_folders_lsp) do
			vim.lsp.buf.add_workspace_folder(line)
		end
	end

	local lspconfig = require('lspconfig')
	lspconfig.jdtls.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			bemol()
		end,
		-- cmd = {
		-- 	"jdtls", -- need to be on your PATH
		-- 	"--jvm-arg=-javaagent:" .. os.getenv("HOME") .. "/Developer/lombok.jar", -- need for lombok magic
		-- 	"-data",
		-- 	eclipse_workspace,
		-- },
	})
end

local function setup()
	require("fidget").setup({})

	-- Setup mason (lsp installer)
	require('mason').setup()
	require('mason-lspconfig').setup({
		ensure_installed = { 'pyright', 'ts_ls', 'yamlls', 'tailwindcss' }
	})

	setup_cmp()

	local packages = require('mason-lspconfig').get_installed_servers()
	local lspconfig = require('lspconfig')

	for _, ls in pairs(packages) do
		local opts = make_config(ls)
		lspconfig[ls].setup(opts)
	end

	vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
	vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

	vim.g.vsnip_filetypes = {
		typescriptreact = { 'typescript' },
		javascriptreact = { 'javascript' },
	}

	-- Metals config setup
	local metals_config = require("metals").bare_config()
	metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Autocmd that will actually be in charging of starting the whole thing
	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		-- NOTE: You may or may not want java included here. You will need it if you
		-- want basic Java support but it may also conflict if you are using
		-- something like nvim-jdtls which also works on a java filetype autocmd.
		pattern = { "scala", "sbt", "java" },
		callback = function()
			require("metals").initialize_or_attach(metals_config)
		end,
		group = nvim_metals_group,
	})

	-- YAML Setup
	lspconfig.yamlls.setup {
		settings = {
			yaml = {
				schemas = {
					kubernetes = "*.yaml",
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
					["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
					["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
					["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
					["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
					["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
					["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
					["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
					["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
					["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
				},
			},
		}
	}

	lspconfig.tailwindcss.setup {
		filetypes = { "typescriptreact", "javascriptreact", "rust", "html" },
		settings = {
			includeLanguages = {
				rust = "html",
			},
		},
	}

	setupAmazon()
end

return {
	-- LSP
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			"j-hui/fidget.nvim",
		},
		init = setup,
	},

	-- Complete
	{
		'hrsh7th/nvim-cmp',
		dependencies = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',

			-- Snippets
			'hrsh7th/vim-vsnip',
			'hrsh7th/vim-vsnip-integ',
			'rafamadriz/friendly-snippets',

		}
	},

	{
		'scalameta/nvim-metals',
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		'akinsho/flutter-tools.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim',
		},
		init         = function()
			require("flutter-tools").setup({
				-- flutter_path = "/usr/bin/flutter/bin/flutter",
				lsp = {
					on_attach = on_attach
				},
				debugger = {
					enabled = true,
					register_configurations = function(paths)
						local dap = require("dap")

						dap.configurations.dart = {
							{
								type = "dart",
								request = "launch",
								name = "Launch flutter",
								dartSdkPath = paths.dart_sdk,
								flutterSdkPath = paths.flutter_sdk,
								program = "${workspaceFolder}/lib/main.dart",
								cwd = "${workspaceFolder}",
								toolArgs = { "-d", "chrome", "--web-port", "5050" }
							},
							{
								type = "dart",
								request = "attach",
								name = "Attach flutter",
								dartSdkPath = paths.dart_sdk,
								flutterSdkPath = paths.flutter_sdk,
								program = "${workspaceFolder}/lib/main.dart",
								cwd = "${workspaceFolder}",
								toolArgs = { "-d", "chrome", "--web-port", "5050" }
							}
						}

						dap.adapaters.dart = {
							args = { "debug-adapter" },
							command = paths.flutter_bin,
							type = "executable"
						}
					end
				}
			})
		end,
	},

	{
		'simrat39/rust-tools.nvim',
		init = function()
			local rt = require("rust-tools")
			rt.setup({
				server = {
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)

						-- Hover actions
						vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions,
							{ buffer = bufnr })
						-- Code action groups
						vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group,
							{ buffer = bufnr })
						vim.keymap.set("n", "<Leader>z", rt.expand_macro.expand_macro,
							{ buffer = bufnr })
					end,
				},
			})
		end,
	}
}
