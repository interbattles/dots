return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      {
        'garymjr/nvim-snippets',
        dependencies = { 'rafamadriz/friendly-snippets' },
        opts = { friendly_snippets = true },
      },
    },
    opts = function ()
      local cmp = require 'cmp'

      return {
        snippet = {
          expand = function (args)
            vim.snippet.expand(args.body)
          end,
        },
        performance = {
          debounce = 10,
          max_view_entries = 25,
        },
        completion = {
          keyword_length = 3,
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
          { name = 'nvim_lsp' },
          { name = 'snippets' },
          { name = 'path' },
          { name = 'buffer' },
        },
      }
    end,
  },
}
