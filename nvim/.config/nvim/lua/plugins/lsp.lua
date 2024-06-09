return {
  'neovim/nvim-lspconfig',

  dependencies = {
    'williamboman/mason.nvim',
  },

  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason')

    mason.setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, {
      capabilities = capabilities,
    })

    lspconfig.rust_analyzer.setup({})
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })
    lspconfig.taplo.setup({})
    lspconfig.bashls.setup({})
  end,
}
