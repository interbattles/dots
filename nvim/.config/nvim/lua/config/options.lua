vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.api.nvim_set_option_value("clipboard", "unnamedplus", { scope = "global" })

vim.opt.number = true -- Print line number
vim.opt.relativenumber = true
