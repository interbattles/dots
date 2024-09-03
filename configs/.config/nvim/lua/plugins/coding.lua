return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      {
        'garymjr/nvim-snippets',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = { friendly_snippets = true },
      },
    },
    opts = function ()
      local cmp = require('cmp')
      local lspkind = require('lspkind')

      return {
        snippet = {
          expand = function (args)
            vim.snippet.expand(args.body)
          end,
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function (_, vim_item)
              return vim_item
            end,
          }),
        },
        performance = {
          debounce = 10,
          max_view_entries = 25,
        },
        completion = {
          keyword_length = 3,
        },
        experimental = {
          ghost_text = true,
        },
        mapping = {
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.confirm({
                select = true,
              })
            else
              fallback()
            end
          end),

          ['<Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function (fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
        },

        sources = {
          { name = 'lazydev',  group_index = 0 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'path',     group_index = 1 },
          { name = 'snippets', group_index = 2 },
          { name = 'buffer',   group_index = 3 },
        },
      }
    end,
    config = function (_, opts)
      local cmp = require 'cmp'
      cmp.setup(opts)

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'path',    group_index = 1 },
          { name = 'cmdline', group_index = 2, option = { ignore_cmds = { 'Man', '!' } } },
        },
      })
    end,
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
        fish = { 'fish_indent' },
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
