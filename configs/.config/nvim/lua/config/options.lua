vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.api.nvim_set_option_value('clipboard', 'unnamedplus', { scope = 'global' })

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.showmode = false


if vim.g.neovide then
  vim.cmd.source '~/.cache/matugen/colors.vim'

  vim.g.neovide_transparency = vim.g.alpha
  vim.g.neovide_window_blurred = false
  vim.g.neovide_show_border = true
  vim.g.neovide_theme = 'auto'
  vim.g.neovide_padding_top = 10
  vim.g.neovide_transparency = 1.0
end
