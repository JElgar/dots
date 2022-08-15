return {
	packages = function(use)
		use({
			'rcarriga/neotest',
  			requires = {
  			  'haydenmeade/neotest-jest',
  			  'nvim-neotest/neotest-python',
  			},
  			config = function()
				require('neotest').setup({
					adapters = {
					  require('neotest-python'),
  			    	  require('neotest-jest')({
  			    	    jestCommand = "npm test --",
  			    	    jestConfigFile = "custom.jest.config.ts",
  			    	    env = { CI = true },
  			    	    cwd = function(path)
							return vim.fn.getcwd()
  			    	    end,
  			    	  }),
  			    	}
				})
			end
		})
	end,
	setup = function()
		-- local neotest = require("neotest")

		-- neotest.setup({
		-- 	adapters = {
		-- 		require("neotest-python")({
		-- 			dap = { justMyCode = false },
		--     	}),
		-- 		require("neotest-plenary"),
		-- 		require("neotest-rust")
		-- 	},
		-- 	require('neotest-jest')({
		-- 		jestCommand = "npm test --",
        -- 	  	jestConfigFile = "custom.jest.config.ts",
        -- 	  	env = { CI = true },
        -- 	  	cwd = function(path)
		-- 			return vim.fn.getcwd()
        -- 	  	end,
        -- 	}),
		-- })

		-- local adapters = neotest.run.adapters()
		-- for a in pairs(adapters) do
		-- 	print(a)
		-- end

		-- local count = 0
		-- for _ in pairs(adapters) do count = count + 1 end
		-- print(count)
	end,
	keybindings = function (bindkey)
	end,
}
