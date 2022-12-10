-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	local opts = { noremap = true, silent = true }
	local args = {
	}
	local function map_buf(mode, key, command) vim.api.nvim_buf_set_keymap(bufnr, mode, key, command, opts) end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map_buf('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
	map_buf('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
	map_buf('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
	map_buf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
	map_buf('n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map_buf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
	map_buf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
	map_buf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
	map_buf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
	map_buf('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
	map_buf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map_buf('n', '<space>E', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	map_buf('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
	map_buf('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
	map_buf('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
	map_buf('n', ',f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

	-- Language Specific
	client.resolved_capabilities.document_formatting = true
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
	c.capabilities = require('cmp_nvim_lsp').update_capabilities(cap)

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

local function setup()
	-- Setup mason (lsp installer)
	require('mason').setup()
	require('mason-lspconfig').setup({
		ensure_installed = { 'sumneko_lua', 'rust_analyzer@nightly', 'pyright', 'tsserver' }
	})

	setup_cmp()

	local packages = require('mason-lspconfig').get_installed_servers()
	local lspconfig = require('lspconfig')
	for _, ls in pairs(packages) do
		local opts = make_config(ls)
		lspconfig[ls].setup(opts)
	end

	vim.g.vsnip_filetypes = {
		typescriptreact = { 'typescript' },
		javascriptreact = { 'javascript' },
	}
end

return {
	on_attach = on_attach,
	packages = function(use)
		use {
			-- LSP
			'neovim/nvim-lspconfig',
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Complete
			'hrsh7th/nvim-cmp',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'hrsh7th/cmp-buffer',

			-- Snippets
			'hrsh7th/vim-vsnip',
			'hrsh7th/vim-vsnip-integ',
			'rafamadriz/friendly-snippets',
		}
	end,
	setup = setup,
}
