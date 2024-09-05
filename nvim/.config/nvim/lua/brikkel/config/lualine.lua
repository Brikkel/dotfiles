local lazy_status = require("lazy.status")

require("lualine").setup({
  options = {
    theme = "monokai-pro", -- Your custom theme
    icons_enabled = true,
    component_separators = { left = "╲", right = "╲" },
    section_separators = { left = "", right = " " },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        separator = { left = "", right = "" },
      },
    },
    lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
    lualine_c = { { "filename", file_status = true, path = 1 } },
    lualine_x = {
      {
        lazy_status.updates,
        cond = lazy_status.has_updates,
        color = { fg = "#FC9867" },
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = {
      {
        "location",
        separator = { left = "", right = "" },
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {},
})
