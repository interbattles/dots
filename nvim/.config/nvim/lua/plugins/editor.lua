return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', },
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
        ['sv'] = { 'actions.select', opts = { vertical = true, }, desc = 'Open the entry in a vertical split', },
        ['sh'] = { 'actions.select', opts = { horizontal = true, }, desc = 'Open the entry in a horizontal split', },
        ['<C-t>'] = { 'actions.select', opts = { tab = true, }, desc = 'Open the entry in new tab', },
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab', }, desc = ':tcd to the current oil directory', },
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      use_default_keymaps = true,
    },
    config = true,
    init = function()
      vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'files', noremap = true, })
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎', },
        change = { text = '▎', },
        delete = { text = '', },
        topdelete = { text = '', },
        changedelete = { text = '▎', },
        untracked = { text = '▎', },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, })
        end

        -- stylua: ignore start
        map('n', ']h', function() gs.nav_hunk('next') end, 'Next Hunk')
        map('n', '[h', function() gs.nav_hunk('prev') end, 'Prev Hunk')
        map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
        map({ 'n', 'v', }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v', }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<leader>ghb', function() gs.blame_line({ full = true, }) end, 'Blame Line')
        map('n', '<leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x', }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
      end,
    },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      plugins = { spelling = true, },
      defaults = {
        mode = { 'n', 'v', },
        ['<leader>b'] = { name = '+buffer', },
        ['<leader>t'] = { name = '+telescope', },
        ['<leader>c'] = { name = '+code', },
        ['<leader>f'] = { name = '+file/find', },
        ['<leader>g'] = { name = '+git', },
        ['<leader>gh'] = { name = '+hunks', ['_'] = 'which_key_ignore', },
        ['<leader>u'] = { name = '+ui', },
        ['<leader>x'] = { name = '+diagnostics/quickfix', },
      },
    },
    config = function(_, opts)
      local wk = require('which-key')
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
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
      vim.keymap.set('n', '<leader>gg', '<cmd>Neogit<cr>', { desc = 'open neogit', noremap = true, })
    end,
  },
}
