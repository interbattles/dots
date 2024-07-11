vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map = vim.keymap.set

if vim.g.neovide then
  map({ 'n', 'v', }, '<C-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  map({ 'n', 'v', }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  map({ 'n', 'v', }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end

-- line editing
map({ 'n', 'x', }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true, })
map({ 'n', 'x', }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true, })
map({ 'n', 'x', }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true, })
map({ 'n', 'x', }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true, })

-- -- window switching
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- ctrl-s save
map({ 'i', 'x', 'n', 's', }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File', })

-- indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- terminal mappings
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode', })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to Left Window', })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to Lower Window', })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to Upper Window', })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to Right Window', })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal', })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore', })

-- buffers
map('n', '<leader>b]', '<Cmd>bnext<CR>', { desc = 'next', })
map('n', '<leader>b[', '<Cmd>bprev<CR>', { desc = 'prev', })
map('n', '<leader>b1', '<Cmd>bfirst<CR>', { desc = 'goto first', })
map('n', '<leader>b0', '<Cmd>blast<CR>', { desc = 'goto last', })
map('n', '<leader>bq', '<Cmd>bdelete<CR>', { desc = 'close current', })

-- tabs
map('n', '<leader><tab>0', '<cmd>tablast<cr>', { desc = 'Last Tab', })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs', })
map('n', '<leader><tab>1', '<cmd>tabfirst<cr>', { desc = 'First Tab', })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New Tab', })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab', })
map('n', '<leader><tab>q', '<cmd>tabclose<cr>', { desc = 'Close Tab', })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab', })
