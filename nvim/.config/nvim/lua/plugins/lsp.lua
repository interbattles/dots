return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      integrations = {
        lspconfig = true,
        cmp = true,
        coq = false,
      },
    },
    config = true,
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'folke/lazydev.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'rust_analyzer', 'lua_ls' },
        handlers = {
          function(server_name) -- default handler (optional)
            require('lspconfig')[server_name].setup {
              capabilities = capabilities,
            }
          end,
          ['lua_ls'] = function()
            require('lspconfig').lua_ls.setup {
              capabilities = capabilities,
              settings = {
                Lua = {
                  format = {
                    enable = true,
                    defaultConfig = {
                      indent_style = 'space',
                      indent_size = '2',
                      quote_style = 'single',
                      space_around_table_field_list = 'true',
                      table_separator_style = 'comma',
                      trailing_table_separator = 'smart',
                    },
                  },
                },
              },
            }
          end,
        },
      })
    end,
  },
}
