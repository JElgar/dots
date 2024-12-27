local function toggleZenMode()
  require("zen-mode").toggle()
end

return {
  "folke/zen-mode.nvim",
  init = function()
    require("zen-mode").setup {
      window = {
        width = 90,
        options = {}
      },
      plugins = {
        kitty = {
          enabled = true,
          font = "+4",
        },
      },
      on_open = function()
        setThemeZen()
      end,
      on_close = function()
        setThemeDark()
      end,
    }
  end,
  keys = {
    {
      "<leader>zz",
      toggleZenMode,
      desc = "Toggle zenmode",
    }
  },
}
