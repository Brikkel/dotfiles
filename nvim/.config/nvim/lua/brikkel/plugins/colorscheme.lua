return{
    {
    "brikkel/monokai-pro.nvim",
    config = function()
      require("monokai-pro").setup()
      vim.cmd([[colorscheme monokai-pro]])
    end,
    priority = 1000,
		}
}
