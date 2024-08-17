vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local function map(mode, lhs, rhs, desc, extra)
  local default = { noremap = true, silent = true, desc = desc or nil }
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('force', default, extra or {}))
end

if vim.g.neovide == true then
  map('n', '<C-=>', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1 end)
  map('n', '<C-->', function () vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1 end)
  map('n', '<C-0>', function () vim.g.neovide_scale_factor = 1 end)
end

-- lazy
map('n', '<leader>ll', '<cmd>Lazy<cr>', 'lazy')
map('n', '<leader>lp', '<cmd>Lazy profile<cr>', 'profiler')
map('n', '<leader>ld', '<cmd>Lazy debug<cr>', 'debugger')
map('n', '<leader>lh', '<cmd>Lazy health<cr>', 'healthcheck')
map('n', '<leader>lu', '<cmd>Lazy update<cr>', 'update')

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', 'quit')

-- line editing
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", 'down', { expr = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", 'down', { expr = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", 'up', { expr = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", 'up', { expr = true })

-- ctrl-s save
map({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', 'save file')

-- indent
map('v', '<', '<gv', 'unindent')
map('v', '>', '>gv', 'indent')

-- block moving
map('v', 'J', ":m '>+1<CR>gv=gv", 'move block down')
map('v', 'K', ":m '<-2<CR>gv=gv", 'move block up')

---- replaced with smart splits
---- move to window using the <ctrl> hjkl keys
--map("n", "<C-h>", "<C-w>h", "go to left window", { remap = true })
--map("n", "<C-j>", "<C-w>j", "go to lower window", { remap = true })
--map("n", "<C-k>", "<C-w>k", "go to upper window", { remap = true })
--map("n", "<C-l>", "<C-w>l", "go to right window", { remap = true })
--
---- resize window using <ctrl> arrow keys
--map('n', '<A-h>', '<C-w><', 'resize left')
--map('n', '<A-l>', '<C-w>>', 'resize right')
--map('n', '<A-k>', '<C-w>-', 'resize up')
--map('n', '<A-j>', '<C-w>+', 'resize down')

-- terminal mappings
map('t', '<esc><esc>', '<c-\\><c-n>', 'enter normal mode')
map('t', '<C-h>', '<cmd>wincmd h<cr>', 'go to left window')
map('t', '<C-j>', '<cmd>wincmd j<cr>', 'go to lower window')
map('t', '<C-k>', '<cmd>wincmd k<cr>', 'go to upper window')
map('t', '<C-l>', '<cmd>wincmd l<cr>', 'go to right window')
map('t', '<C-/>', '<cmd>close<cr>', 'hide terminal')

-- buffers
map('n', ']b', '<cmd>bnext<cr>', 'next buffer')
map('n', '[b', '<cmd>bprev<cr>', 'prev buffer')
map('n', '<leader>b0', '<cmd>blast<cr>', 'goto last')
map('n', '<leader>b1', '<cmd>bfirst<cr>', 'goto first')
map('n', '<leader>bb', '<cmd>ene <bar> startinsert<cr>', 'new buffer')
map('n', '<leader>bq', '<cmd>bdelete<cr>', 'close current')
map('n', '<leader>bc', '<cmd>%bd<cr>', 'clear buffers')
map('n', '<leader>bo', '<cmd>%bd<bar>e#<bar>bd#<cr>', 'close others')

-- tabs
map('n', '<leader><tab>0', '<cmd>tablast<cr>', 'last tab')
map('n', '<leader><tab>1', '<cmd>tabfirst<cr>', 'first tab')
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', 'new tab')
map('n', ']<tab>', '<cmd>tabnext<cr>', 'next tab')
map('n', '[<tab>', '<cmd>tabprevious<cr>', 'previous tab')
map('n', '<leader><tab>q', '<cmd>tabclose<cr>', 'close tab')
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', 'close other tabs')

-- clipboard
map('n', '<leader>y', '"+y', 'yank to clipboard')
map({ 'v', 'x' }, '<leader>y', '"+y', 'yank to clipboard')
map({ 'n', 'v', 'x' }, '<leader>yy', '"+yy', 'yank line to clipboard')
map({ 'n', 'v', 'x' }, '<leader>Y', '"+yy', 'yank line to clipboard')
map({ 'n', 'v', 'x' }, '<C-a>', 'gg0vG$', 'select all')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p', 'paste from clipboard')
map('i', '<C-p>', '<C-r>+', 'paste from clipboard from within insert mode')
map('x', '<leader>P', '"_dP', 'paste over selection without erasing unnamed register')
