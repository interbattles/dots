return {
  {
    'folke/lazydev.nvim',
    dependencies = {
      'Bilal2453/luvit-meta',
      'justinsgithub/wezterm-types',
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
      { path = "wezterm-types", mods = { "wezterm" } },
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
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function ()
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
            },
          },
        },
      }
      local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
      cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true
      lspconfig.cssls.setup {
        capabilities = cssls_capabilities
      }

      lspconfig.rust_analyzer.setup {}
      lspconfig.taplo.setup {}
      lspconfig.hyprls.setup {}
      lspconfig.vimls.setup {}
      lspconfig.fish_lsp.setup {}
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function ()
      require('mason').setup()
      require('mason-lspconfig').setup()

      require('mason-tool-installer').setup({
        ensure_installed = {
          'rust_analyzer',
          'lua_ls',
          'hyprls',
          'vimls',
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
