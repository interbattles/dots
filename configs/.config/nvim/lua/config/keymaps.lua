vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local map = vim.keymap.set

if vim.g.neovide == true then
  map('n', '<C-=>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end,
    { silent = true })
  map('n', '<C-->', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end,
    { silent = true })
  map('n', '<C-0>', function () vim.g.neovide_scale_factor = 1 end, { silent = true })
end

-- lazy
map('n', '<leader>ll', '<cmd>Lazy<cr>', { desc = 'lazy' })
map('n', '<leader>lp', '<cmd>Lazy profile<cr>', { desc = 'profiler' })
map('n', '<leader>ld', '<cmd>Lazy debug<cr>', { desc = 'debugger' })
map('n', '<leader>lh', '<cmd>Lazy health<cr>', { desc = 'healthcheck' })
map('n', '<leader>lu', '<cmd>Lazy update<cr>', { desc = 'update' })

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
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move block down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move block up' })

---- replaced with smart splits
---- move to window using the <ctrl> hjkl keys
--map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
--map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
--map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
--map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
--
---- resize window using <ctrl> arrow keys
--map('n', '<A-h>', '<C-w><', { desc = 'resize left' })
--map('n', '<A-l>', '<C-w>>', { desc = 'resize right' })
--map('n', '<A-k>', '<C-w>-', { desc = 'resize up' })
--map('n', '<A-j>', '<C-w>+', { desc = 'resize down' })

-- terminal mappings
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'enter normal mode' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'go to right window' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'hide terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- buffers
map('n', ']b', '<cmd>bnext<cr>', { desc = 'next buffer' })
map('n', '[b', '<cmd>bprev<cr>', { desc = 'prev buffer' })
map('n', '<leader>b0', '<cmd>blast<cr>', { desc = 'goto last' })
map('n', '<leader>b1', '<cmd>bfirst<cr>', { desc = 'goto first' })
map('n', '<leader>bb', '<cmd>ene <bar> startinsert<cr>', { desc = 'new buffer' })
map('n', '<leader>bq', '<cmd>bdelete<cr>', { desc = 'close current' })
map('n', '<leader>bc', '<cmd>%bd<cr>', { desc = 'clear buffers' })

-- tabs
map('n', '<leader><tab>0', '<cmd>tablast<cr>', { desc = 'last tab' })
map('n', '<leader><tab>1', '<cmd>tabfirst<cr>', { desc = 'first tab' })
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'new tab' })
map('n', ']<tab>', '<cmd>tabnext<cr>', { desc = 'next tab' })
map('n', '[<tab>', '<cmd>tabprevious<cr>', { desc = 'previous tab' })
map('n', '<leader><tab>q', '<cmd>tabclose<cr>', { desc = 'close tab' })
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'close other tabs' })

-- clipboard
map('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
map({ 'v', 'x' }, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'yank to clipboard' })
map({ 'n', 'v', 'x' }, '<leader>yy', '"+yy', { noremap = true, silent = true, desc = 'yank line to clipboard' })
map({ 'n', 'v', 'x' }, '<leader>Y', '"+yy', { noremap = true, silent = true, desc = 'yank line to clipboard' })
map({ 'n', 'v', 'x' }, '<C-a>', 'gg0vG$', { noremap = true, silent = true, desc = 'select all' })
map({ 'n', 'v', 'x' }, '<leader>p', '"+p', { noremap = true, silent = true, desc = 'paste from clipboard' })
map('i', '<C-p>', '<C-r>+', { noremap = true, silent = true, desc = 'paste from clipboard from within insert mode' })
map('x', '<leader>P', '"_dP',
  { noremap = true, silent = true, desc = 'paste over selection without erasing unnamed register' })
