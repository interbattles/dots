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
          max_view_entries = 50,
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
        python = { 'black', lsp_format = 'fallback' },
        json = { 'jq' },
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
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    keys = {
      {
        '<leader>cl',
        function ()
          require('lint').try_lint()
        end,
        desc = 'lint',
        mode = { 'n', 'x' },
      },
    },
    opts = {
      events = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
      linters_by_ft = {
        golangcilint = { 'go' },
        mypy = { 'python' },
      },
    },
    config = function (_, opts)
      local lint = require('lint')
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
        callback = function ()
          require('lint').try_lint()
        end,
      })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',

    dependencies = {
      { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
      -- virtual text for the debugger
      {
        'theHamsta/nvim-dap-virtual-text',
        'leoluz/nvim-dap-go',
        opts = {},
      },
    },

    -- stylua: ignore
    keys = {
      { '<leader>dU', function () require('dapui').open() end,                                               desc = 'open dap ui' },
      { '<leader>d',  '',                                                                                    desc = '+debug',                 mode = { 'n', 'v' } },
      { '<leader>dB', function () require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
      { '<leader>db', function () require('dap').toggle_breakpoint() end,                                    desc = 'Toggle Breakpoint' },
      { '<leader>dc', function () require('dap').continue() end,                                             desc = 'Run/Continue' },
      { '<leader>da', function () require('dap').continue({ before = get_args }) end,                        desc = 'Run with Args' },
      { '<leader>dC', function () require('dap').run_to_cursor() end,                                        desc = 'Run to Cursor' },
      { '<leader>dg', function () require('dap').goto_() end,                                                desc = 'Go to Line (No Execute)' },
      { '<leader>di', function () require('dap').step_into() end,                                            desc = 'Step Into' },
      { '<leader>dj', function () require('dap').down() end,                                                 desc = 'Down' },
      { '<leader>dk', function () require('dap').up() end,                                                   desc = 'Up' },
      { '<leader>dl', function () require('dap').run_last() end,                                             desc = 'Run Last' },
      { '<leader>do', function () require('dap').step_out() end,                                             desc = 'Step Out' },
      { '<leader>dO', function () require('dap').step_over() end,                                            desc = 'Step Over' },
      { '<leader>dp', function () require('dap').pause() end,                                                desc = 'Pause' },
      { '<leader>dr', function () require('dap').repl.toggle() end,                                          desc = 'Toggle REPL' },
      { '<leader>ds', function () require('dap').session() end,                                              desc = 'Session' },
      { '<leader>dt', function () require('dap').terminate() end,                                            desc = 'Terminate' },
      { '<leader>dw', function () require('dap.ui.widgets').hover() end,                                     desc = 'Widgets' },
    },
    config = function ()
      require('dapui').setup()
      require('dap-go').setup()
    end,
  },
}
