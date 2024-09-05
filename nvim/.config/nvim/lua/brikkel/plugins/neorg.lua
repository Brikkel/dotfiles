return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    run = ":Neorg sync-parsers",
    -- put any other flags you wanted to pass to lazy here!
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.unmap("norg", "n", "gtd")
                keybinds.map("norg", "n", "gtd", "<cmd>Lazy<CR>")
              end,
            },
          },
          ["core.concealer"] = {
            config = {
              folds = false, -- if this is true, when exeting neorg it will fold all tables automatically
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                entertainment = "~/notes/entertainment/",
                tech = "~/notes/tech/",
              },
              default_workspace = "notes",
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Go to index file of current workspace" },
      { "<leader>nd", "<cmd>Neorg workspace<cr>", desc = "Open default workspace" },
      { "<leader>nr", "<cmd>Neorg return<cr>", desc = "Exit out of Neorg workspace" },
      { "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", desc = "Go to index file of current workspace" },
      { "<leader>id", "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_done<CR>", desc = "toggle todo to done" },

      { "<leader>nn", "<cmd>Neorg workspace notes<cr>", desc = "Open notes workspace" },
      { "<leader>nt", "<cmd>Neorg workspace tech<cr>", desc = "Open tech workspace" },
      { "<leader>ne", "<cmd>Neorg workspace entertainment<cr>", desc = "Open entertainment workspace" },

      {
        "<leader>iu",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_undone<CR>",
        desc = "toggle todo to undone",
      },
      {
        "<leader>ip",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_pending<CR>",
        desc = "toggle todo to pending",
      },
      {
        "<leader>ih",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_on_hold<CR>",
        desc = "toggle todo to on hold",
      },
      {
        "<leader>ic",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_cancelled<CR>",
        desc = "toggle todo to cancelled",
      },
      {
        "<leader>ir",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>",
        desc = "toggle todo to recurring",
      },
      {
        "<leader>ii",
        "<cmd>Neorg keybind norg core.qol.todo_items.todo.task_recurring<CR>",
        desc = "toggle todo to important",
      },
      {
        "<leader>in",
        "o- ( ) <esc>",
        desc = "create a new item",
      },
    },
  },
}
