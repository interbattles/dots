return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
<<<<<<< HEAD
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
=======
      { 'onsails/lspkind.nvim' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
>>>>>>> eww
      {
        'garymjr/nvim-snippets',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = { friendly_snippets = true },
      },
    },
    opts = function ()
      local cmp = require 'cmp'
<<<<<<< HEAD
=======
      local lspkind = require 'lspkind'
>>>>>>> eww

      return {
        snippet = {
          expand = function (args)
            vim.snippet.expand(args.body)
          end,
        },
<<<<<<< HEAD
        performance = {
          debounce = 10,
          max_view_entries = 25,
        },
        completion = {
          keyword_length = 3,
        },
=======
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
>>>>>>> eww
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
<<<<<<< HEAD
          { name = 'nvim_lsp' },
          { name = 'snippets' },
          { name = 'path' },
          { name = 'buffer' },
=======
          { name = 'lazydev',  group_index = 0 },
          { name = 'nvim_lsp', group_index = 1 },
          { name = 'path',     group_index = 1 },
          { name = 'snippets', group_index = 2 },
          { name = 'buffer',   group_index = 3 },
>>>>>>> eww
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
}
