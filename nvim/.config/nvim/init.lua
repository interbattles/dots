vim.o.termguicolors = true

-- must be before lazy
vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = '\\' -- Same for `maplocalleader`

-- vim.opt.fillchars:append('vert:▕')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')
require('keymaps')
require('formatting')

vim.cmd('hi Normal ctermbg=NONE guibg=NONE')
vim.cmd('hi NonText ctermbg=NONE guibg=NONE')
