vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.api.nvim_set_option_value("clipboard", "unnamedplus", {
  scope = "global"
})
