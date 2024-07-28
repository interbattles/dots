return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
      plugins = { spelling = true },
      preset = 'modern',
    },
    config = function (_, opts)
      local wk = require('which-key')
      wk.setup(opts)

      wk.add({
        {
          mode = { 'n', 'v' },
          { '<leader><Tab>', group = 'tabs' },
          { '<leader>b',     group = 'buffer' },
          { '<leader>q',     group = 'quit' },
          { '<leader>f',     group = 'file/find' },
          { '<leader>g',     group = 'git' },
          { '<leader>gh',    group = 'hunks' },
          { '<leader>t',     group = 'terminal/toggleterm' },
          { '<leader>u',     group = 'ui' },
          { '<leader>s',     group = 'session' },
          { '<leader>x',     group = 'diagnostics/quickfix' },
          { '<leader>c',     group = 'code' },
          {
            '<leader>ct',
            group = 'trouble',
            icon = { icon = '󱖫', color = 'green' },
          },
        },
      })
    end,
  },
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      scope = 'git',
      icons = true,
      status = true,
    },
    keys = {
      { '<C-t>', '<cmd>Grapple toggle<cr>',          desc = 'tag a file' },
      { ';',     '<cmd>Grapple toggle_tags<cr>',     desc = 'toggle tags menu' },

      { '<C-1>', '<cmd>Grapple select index=1<cr>',  desc = 'select first tag' },
      { '<C-2>', '<cmd>Grapple select index=2<cr>',  desc = 'select second tag' },
      { '<C-3>', '<cmd>Grapple select index=3<cr>',  desc = 'select third tag' },
      { '<C-4>', '<cmd>Grapple select index=4<cr>',  desc = 'select fourth tag' },

      { ',',     '<cmd>Grapple cycle_tags prev<cr>', desc = 'go to previous tag' },
      { '.',     '<cmd>Grapple cycle_tags next<cr>', desc = 'go to next tag' },
    },
    init = function ()
      require('telescope').load_extension 'grapple'
    end,
  },
  {
    'echasnovski/mini.files',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = {
      mappings = {
        close       = 'q',
        go_in       = '',
        go_in_plus  = '<CR>',
        go_out      = '-',
        go_out_plus = '_',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
    },
    config = function (_, opts)
      local MiniFiles = require('mini.files')
      MiniFiles.setup(opts)

      vim.keymap.set('n', '-', MiniFiles.open, { desc = 'open minifiles' })

      local files_set_cwd = function ()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function (args)
          vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id })
        end,
      })

      local map_split = function (buf_id, lhs, direction)
        local rhs = function ()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_target_window() --[[@as number]], function ()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
        end

        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function (args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, 'gs', 'belowright horizontal')
          map_split(buf_id, 'gv', 'belowright vertical')
        end,
      })
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
      on_attach = function (buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map('n', ']h', function () gs.nav_hunk('next') end, 'next hunk')
        map('n', '[h', function () gs.nav_hunk('prev') end, 'prev hunk')
        map('n', ']H', function () gs.nav_hunk('last') end, 'last hunk')
        map('n', '[H', function () gs.nav_hunk('first') end, 'first hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'stage hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'reset hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'stage buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'undo stage hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'reset buffer')
        map('n', '<leader>ghp', gs.preview_hunk_inline, 'preview hunk inline')
        map('n', '<leader>ghb', function () gs.blame_line({ full = true }) end, 'blame line')
        map('n', '<leader>ghd', gs.diffthis, 'diff this')
        map('n', '<leader>ghD', function () gs.diffthis('~') end, 'diff this ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'gitsigns select hunk')
      end,
    },
  },
  {
    'NeogitOrg/neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'open neogit' },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = true,
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
    keys = {
      { '<leader>cc', '<cmd>ColorizerToggle<cr>', desc = 'toggle colorizer', noremap = true },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function () vim.fn['mkdp#util#install']() end,
  },
}
