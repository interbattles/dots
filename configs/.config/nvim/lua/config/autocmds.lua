-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'lsp actions',
  callback = function (event)
    vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = 'definition', buffer = event.buf })
    vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, { desc = 'declaration', buffer = event.buf })
    vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, { desc = 'implementations', buffer = event.buf })
    vim.keymap.set('n', '<leader>co', vim.lsp.buf.type_definition, { desc = 'type definition', buffer = event.buf })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, { desc = 'references', buffer = event.buf })
    vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, { desc = 'rename', buffer = event.buf })
    vim.keymap.set({ 'n', 'x' }, '<leader>cf', vim.lsp.buf.format, { desc = 'format', buffer = event.buf })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'code actions', buffer = event.buf })
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'auto format on save',
  callback = function (event)
    vim.lsp.buf.format({ bufnr = event.buf })
  end,
})
