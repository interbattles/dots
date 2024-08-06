return {
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    lazy = true,
    cmd = 'Grapple',
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
    opts = {
      scope = 'git',
      icons = true,
      status = true,
    },
  },
  {
    'echasnovski/mini.files',
    lazy = true,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    keys = {
      { '-', '<cmd>lua require("mini.files").open()<cr>', desc = 'files' },
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

      local files_set_cwd = function ()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function (args)
          vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id, desc = ':cd mini.files dir' })
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

        local desc = 'split ' .. direction
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
    'NeogitOrg/neogit',
    lazy = true,
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'open neogit' },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim',        lazy = true },
      { 'sindrets/diffview.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = true,
  },
  {
    'folke/trouble.nvim',
    lazy = true,
    cmd = 'Trouble',
    opts = {},
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
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    config = function ()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- dashboard.section.terminal.type = 'terminal'
      -- dashboard.section.terminal.command = 'lolcrab ~/.config/nvim/arts/dashboard.txt'
      -- dashboard.section.terminal.width = 69
      -- dashboard.section.terminal.height = 10

      local function entry(icon, desc, key, action)
        return dashboard.button(key, icon .. ' ' .. desc, '<cmd>' .. action .. '<cr>')
      end

      dashboard.section.buttons.val = {
        entry('', 'new file', 'e', 'ene | startinsert'),
        entry('󰦛', 'restore session', 's', 'SessionManager load_session'),
        entry('󰥨', 'find files', 'f', 'Telescope find_files'),
        entry('󱎫', 'recent files', 'r', 'Telescope oldfiles'),
        entry('󰅚', 'quit nvim', 'q', 'qa'),
      }

      dashboard.config.layout = {
        -- dashboard.section.terminal,
        -- { type = 'padding', val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      }

      alpha.setup(dashboard.opts)

      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function ()
            require('lazy').show()
          end,
        })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        desc = 'add alpha dashboard footer',
        once = true,
        callback = function ()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '󰏋 loaded ' ..
              stats.loaded .. ' / 󱑥 ' .. stats.count .. ' plugins (' .. ms .. 'ms)'

          vim.cmd 'AlphaRedraw'
        end,
      })
    end,
  },

}
