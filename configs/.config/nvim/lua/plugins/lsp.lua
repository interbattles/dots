return {
  { 'Bilal2453/luvit-meta',        lazy = true },
  { 'justinsgithub/wezterm-types', lazy = true },
  {
    'folke/lazydev.nvim',
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
        { path = 'wezterm-types', mods = { 'wezterm' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim',      dependencies = { 'williamboman/mason-lspconfig.nvim' } },
      { 'pmizio/typescript-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
      { 'hrsh7th/cmp-nvim-lsp',         dependencies = { 'hrsh7th/nvim-cmp' } },
    },
    config = function ()
      local lspconfig = require('lspconfig')
      local handlers = {
        tsserver = function () end,
        function (server) lspconfig[server].setup(require('config.lsp')[server]) end,
      }

      require('typescript-tools').setup {}

      require('mason-lspconfig').setup {
        ensure_installed = {
          'rust_analyzer',
          'lua_ls',
          'vimls',
        },
        handlers = handlers,
      }
    end,
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
}
