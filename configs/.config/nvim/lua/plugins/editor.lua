return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      plugins = { spelling = true },
      preset = 'modern'
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)

      wk.add({
        {
          mode = { 'n', 'v' },
          { '<leader><Tab>', group = 'tabs' },
          { '<leader>b', group = 'buffer' },
          { '<leader>c', group = 'code' },
          { '<leader>ct', group = 'trouble', icon = { icon = '󱖫', color = 'green' } },
          { '<leader>f', group = 'file/find' },
          { '<leader>g', group = 'git' },
          { '<leader>gh', group = 'hunks' },
          { '<leader>t', group = 'telescope' },
          { '<leader>u', group = 'ui' },
          { '<leader>x', group = 'diagnostics/quickfix' },
        },
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, _)
          return vim.startswith(name, '.')
        end,
        is_always_hidden = function(name, _)
          return name == '..'
        end,
      },
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['-'] = { 'actions.select', opts = { vertical = true }, desc = 'open the entry in a vertical split' },
        ['|'] = { 'actions.select', opts = { horizontal = true }, desc = 'open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'open the entry in new tab' },
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
        [';'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      use_default_keymaps = false,
    },
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'files', noremap = true })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map('n', ']h', function() gs.nav_hunk('next') end, 'next hunk')
        map('n', '[h', function() gs.nav_hunk('prev') end, 'prev hunk')
        map('n', ']H', function() gs.nav_hunk('last') end, 'last hunk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'first hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'stage hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'reset hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'stage buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'undo stage hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'reset buffer')
        map('n', '<leader>ghp', gs.preview_hunk_inline, 'preview hunk inline')
        map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'blame line')
        map('n', '<leader>ghd', gs.diffthis, 'diff this')
        map('n', '<leader>ghD', function() gs.diffthis('~') end, 'diff this ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'gitsigns select hunk')
      end,
    },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',  -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
    },
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'open neogit', noremap = true })
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'diagnostics (trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'buffer diagnostics (trouble)',
      },
      {
        '<leader>cts',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'symbols',
      },
      {
        '<leader>ctl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'lsp definitions / references / ...',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'location list (trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'quickfix list (trouble)',
      },
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>cc', '<cmd>ColorizerToggle<cr>', { desc = 'toggle colorizer', noremap = true })
    end,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function() vim.fn['mkdp#util#install']() end,
  },
}
