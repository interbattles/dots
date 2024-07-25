local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'lsp actions',
  callback = function (args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end

    vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = 'definition', buffer = bufnr })
    vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, { desc = 'declaration', buffer = bufnr })
    vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation, { desc = 'implementations', buffer = bufnr })
    vim.keymap.set('n', '<leader>co', vim.lsp.buf.type_definition, { desc = 'type definition', buffer = bufnr })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references, { desc = 'references', buffer = bufnr })
    vim.keymap.set('n', '<leader>cn', vim.lsp.buf.rename, { desc = 'rename', buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'code actions', buffer = bufnr })

    if client.supports_method('textDocument/formatting') then
      vim.keymap.set({ 'n', 'x' }, '<leader>cf', vim.lsp.buf.format, { desc = 'format', buffer = bufnr })

      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = vim.lsp.buf.format,
      })
    end
  end,
})
