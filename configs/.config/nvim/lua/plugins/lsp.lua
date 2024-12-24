return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    dependencies = {
      { 'hrsh7th/nvim-cmp' },
      { 'neovim/nvim-lspconfig' },

      { 'Bilal2453/luvit-meta' },
      { 'justinsgithub/wezterm-types' },
    },
    opts = {
      library = {
        'lazy.nvim',
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'wezterm-types',      mods = { 'wezterm' } },
      },
    },
  },
  {
    'eraserhd/parinfer-rust',
    ft = { 'yuck' },
    build = 'cargo build --release',
    init = function ()
      vim.g.parinfer_mode = 'smart'
      vim.g.parinfer_force_balance = 1
    end,
  },
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = vim.fn.argc(-1) == 0,
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    after = 'folke/neoconf.nvim',
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function () end,
        dependencies = { 'mason.nvim' },
      },
    },
    keys = {
      { '<leader>cR', '<cmd>LspRestart<cr>', desc = 'reload LSP' },
    },
    config = function ()
      local lspconfig = require('lspconfig')
      local handlers = {
        function (server) lspconfig[server].setup(require('config.lsp')[server]) end,
        ['gleam'] = lspconfig.gleam.setup(require('config.lsp')['gleam']),
      }

      require('mason-lspconfig').setup {
        ensure_installed = {
          'rust_analyzer',
          'lua_ls',
          'vimls',
          'tsserver',
        },
        handlers = handlers,
      }
    end,
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = {
      { '<leader>cm', '<cmd>Mason<cr>', desc = 'mason' },
    },
    build = ':MasonUpdate',
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
