return {
  {
    'folke/lazydev.nvim',
    dependencies = {
      'Bilal2453/luvit-meta',
    },
    ft = 'lua',
    opts = {
      integrations = {
        lspconfig = true,
        cmp = true,
        coq = false,
      },
      library = {
        'lazy.nvim',
        'luvit-meta/library',
      },
    },
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
    'neovim/nvim-lspconfig',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.util.default_config = vim.tbl_extend(
        'force',
        lspconfig.util.default_config,
        {
          autostart = true,
          capabilities = capabilities,
        }
      )

      lspconfig.lua_ls.setup {
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
      lspconfig.rust_analyzer.setup {}
      lspconfig.hyprls.setup {}

      -- custom servers setup
      local configs = require 'lspconfig.configs'
      if not configs.fish_lsp then
        configs.fish_lsp_lsp = {
          default_config = {
            cmd = { 'fish-lsp', 'start' },
            filetypes = { 'fish' },
            root_dir = function(fname)
              return lspconfig.util.find_git_ancestor(fname)
            end,
            settings = {},
          },
        }
      end
      lspconfig.fish_lsp.setup {}
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()

      require('mason-tool-installer').setup({
        ensure_installed = {
          'rust_analyzer',
          'lua_ls',
          'hyprls',
        },
        run_on_start = true,
        integrations = {
          ['mason-lspconfig'] = true,
        },
      })
    end,
  },
  -- {
  --   'neovim/nvim-lspconfig',
  --   config = function()
  --     local lspconfig = require 'lspconfig'
  --     local configs = require 'lspconfig.configs'
  --     if not configs.fish_lsp then
  --       configs.fish_lsp_lsp = {
  --         default_config = {
  --           cmd = { 'fish-lsp', 'start' },
  --           filetypes = { 'fish' },
  --           root_dir = function(fname)
  --             return lspconfig.util.find_git_ancestor(fname)
  --           end,
  --           settings = {},
  --         },
  --       }
  --     end
  --     lspconfig.fish_lsp.setup {}
  --   end,
  -- },
}
