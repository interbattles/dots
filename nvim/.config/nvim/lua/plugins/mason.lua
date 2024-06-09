return {
  'williamboman/mason.nvim',
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        automatic_installation = true,
        ensure_installed = { 'lua_ls', 'rust_analyzer' },
      })
    end,
  },
}
