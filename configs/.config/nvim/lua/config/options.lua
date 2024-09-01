vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.cmdheight = 0

if vim.g.neovide then
  vim.cmd.source '~/.cache/matugen/colors.vim'

  vim.g.neovide_transparency = vim.g.alpha
  vim.g.neovide_window_blurred = false
  vim.g.neovide_show_border = true
  vim.g.neovide_theme = 'auto'
  vim.g.neovide_padding_top = 10
end

vim.o.shortmess = 'ltToOCF'
