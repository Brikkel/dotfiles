local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  checker = {
    enabled = true,
    notify = false,
  },
  spec = {
    { import = "brikkel.plugins" },
    { import = "brikkel.plugins.lsp" },
  },
  change_detection = {
    notify = false,
  },
  opts = { use_default_keymaps = false },
})
