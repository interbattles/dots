vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map = vim.keymap.set

if vim.g.neovide then
  map({ 'n', 'v' }, '<C-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>')
  map({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>')
  map({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<CR>')
end

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'quit' })

-- line editing
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'up', expr = true, silent = true })

-- ctrl-s save
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'save file' })

-- indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- block moving
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block up" })

-- REPLACED W/ SMART SPLITS.NVIM
-- REPLACED W/ SMART SPLITS.NVIM
-- REPLACED W/ SMART SPLITS.NVIM
-- REPLACED W/ SMART SPLITS.NVIM
--
-- -- move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- 
-- -- resize window using <ctrl> arrow keys
-- map("n", "<A-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- map("n", "<A-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- map("n", "<A-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- map("n", "<A-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- terminal mappings
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'enter normal mode' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'go to right window' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'hide terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- buffers
-- REPLACED BY BUFFERLINE
-- map('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })
-- map('n', '[b', '<cmd>bprev<cr>', { desc = 'prev buffer' })
map({'n','v'}, '<leader>b1', '<cmd>bfirst<cr>', { desc = 'goto first' })
map({'n','v'}, '<leader>b0', '<cmd>blast<cr>', { desc = 'goto last' })
map({'n','v'}, '<leader>bq', '<cmd>bdelete<cr>', { desc = 'close current' })

-- tabs
map('n', '<leader><tab>0', '<cmd>tablast<cr>', { desc = 'last tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'close other tabs' })
map('n', '<leader><tab>1', '<cmd>tabfirst<cr>', { desc = 'first tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'new tab' })
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'next tab' })
map('n', '<leader><tab>q', '<cmd>tabclose<cr>', { desc = 'close tab' })
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'previous tab' })

-- lsp
map('n', '<leader>cf', vim.lsp.buf.format, { desc = 'format buffer' })
map("n", "<leader>cd", vim.lsp.buf.definition, { desc = 'definition' })
map("n", "<leader>ci", vim.lsp.buf.implementation, { desc = 'implementations' })
map("n", "<leader>cn", vim.lsp.buf.rename, { desc = 'rename' })
map("n", "<leader>cr", vim.lsp.buf.references, { desc = 'references' })
