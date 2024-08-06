return {
  { 'gpanders/nvim-parinfer' },
  {
    'pmizio/typescript-tools.nvim',
    lazy = true,
    ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' },
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
      { 'neovim/nvim-lspconfig' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    lazy = vim.fn.argc(-1) == 0,
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp',        dependencies = { 'hrsh7th/nvim-cmp' } },
      { 'Bilal2453/luvit-meta',        lazy = true },
      { 'justinsgithub/wezterm-types', lazy = true },
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
