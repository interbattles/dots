return {
  {
    'lambdalisue/vim-suda',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tf',     '<cmd>ToggleTerm direction=float<cr>',      desc = 'floating' },
      { '<leader>th',     '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'horizontal' },
      { '<leader>tv',     '<cmd>ToggleTerm direction=vertical<cr>',   desc = 'vertical' },
      { '<leader>t<tab>', '<cmd>ToggleTerm direction=tab<cr>',        desc = 'tab' },
      { '<A-t>',          '<cmd>ToggleTerm<cr>',                      desc = 'toggle' },
    },
    opts = {
      open_mapping = '<A-t>',
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    event = 'VeryLazy',
    config = true,
    keys = {
      { '<A-h>',   '<cmd>lua require("smart-splits").resize_left()<cr>' },
      { '<A-j>',   '<cmd>lua require("smart-splits").resize_down()<cr>' },
      { '<A-k>',   '<cmd>lua require("smart-splits").resize_up()<cr>' },
      { '<A-l>',   '<cmd>lua require("smart-splits").resize_right()<cr>' },
      { '<C-h>',   '<cmd>lua require("smart-splits").move_cursor_left()<cr>' },
      { '<C-j>',   '<cmd>lua require("smart-splits").move_cursor_down()<cr>' },
      { '<C-k>',   '<cmd>lua require("smart-splits").move_cursor_up()<cr>' },
      { '<C-l>',   '<cmd>lua require("smart-splits").move_cursor_right()<cr>' },
      { '<C-\\>',  '<cmd>lua require("smart-splits").move_cursor_previous' },
      { '<C-S-H>', '<cmd>lua require("smart-splits").swap_buf_left()<cr>',    desc = 'swap left' },
      { '<C-S-J>', '<cmd>lua require("smart-splits").swap_buf_down()<cr>',    desc = 'swap down' },
      { '<C-S-K>', '<cmd>lua require("smart-splits").swap_buf_up()<cr>',      desc = 'swap up' },
      { '<C-S-L>', '<cmd>lua require("smart-splits").swap_buf_right()<cr>',   desc = 'swap right' },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', '<cmd>Telescope file_browser<cr>',                                      desc = 'files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>',                                         desc = 'grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>',                                           desc = 'buffers' },
      { '<leader>ff', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', desc = 'find all' },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>',                                         desc = 'help tags' },
      { '<leader>fc', '<cmd>Telescope command_history<CR>',                                   desc = 'command history' },
      { '<leader>fo', '<cmd>Telescope oldfiles<CR>',                                          desc = 'old files' },
      { '<leader>ft', '<cmd>Telescope colorscheme<CR>',                                       desc = 'colorschemes' },
    },
    opts = function ()
      local config = require('telescope.config')

      local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, '--hidden')
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      return {
        defaults = {
          initial_mode = 'normal',
          vimgrep_arguments = vimgrep_arguments,
        },

        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,

    config = function (_, opts)
      require('telescope').setup(opts)
    end,
  },
  {
    'rmagatti/auto-session',
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    config = function ()
      require('auto-session').setup({
        auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
        auto_save_enabled = true,
        auto_restore_enabled = false,
        auto_session_use_git_branch = true,
        auto_session_create_enabled = function ()
          local cmd = 'git rev-parse --is-inside-work-tree'
          return vim.fn.system(cmd) == 'true\n'
        end,
      })
    end,
    init = function ()
      vim.keymap.set('n', '<leader>sl', '<cmd>Telescope session-lens<cr>', { desc = 'session lens' })
      vim.keymap.set('n', '<leader>fs', '<cmd>Telescope session-lens<cr>', { desc = 'sessions' })
    end,
  },
}
