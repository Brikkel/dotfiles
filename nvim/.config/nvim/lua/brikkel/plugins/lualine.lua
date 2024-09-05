-- .config/nvim/lua/plugins/plugins.lua
return {
  "nvim-lualine/lualine.nvim",
  requires = { "kyazdani42/nvim-web-devicons" }, -- If you want icons in lualine
  config = function()
    require("brikkel.config.lualine") -- Loads lualine configuration from the config directory
  end,
}
