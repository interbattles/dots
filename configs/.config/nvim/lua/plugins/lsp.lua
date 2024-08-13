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
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp', dependencies = { 'hrsh7th/nvim-cmp' } },
      {
        'williamboman/mason-lspconfig.nvim',
        config = function () end,
        dependencies = { 'mason.nvim' },
      },
    },
    config = function ()
      local lspconfig = require('lspconfig')
      local handlers = {
        function (server) lspconfig[server].setup(require('config.lsp')[server]) end,
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
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function ()
          require('conform').format({ async = true })
        end,
        desc = 'format',
        mode = { 'n', 'x' },
      },
    },
    opts = {
      formatters_by_ft = {
        rust = { 'rustfmt', lsp_format = 'fallback' },
        bash = { 'shfmt', lsp_format = 'fallback' },
        sh = { 'shfmt', lsp_format = 'fallback' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      format_on_save = { timeout_ms = 500 },
      formatters = {},
    },
    init = function ()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
