return {
  { 'Bilal2453/luvit-meta',        lazy = true },
  { 'justinsgithub/wezterm-types', lazy = true },
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
        rust_analyzer = function () end,
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
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
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
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function ()
          require('conform').format({ async = true })
        end,
        mode = { 'n', 'x' },
        desc = 'format',
      },
    },
    opts = {
      formatters_by_ft = {},
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
