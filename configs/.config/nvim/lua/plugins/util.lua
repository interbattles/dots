return {
  { 'nvim-lua/plenary.nvim', lazy = true },
  {
    'lambdalisue/vim-suda',
    cmd = { 'SudaWrite', 'SudaRead' },
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<leader>tf',     '<cmd>ToggleTerm direction=float<cr>',      desc = 'floating' },
      { '<leader>th',     '<cmd>ToggleTerm direction=horizontal<cr>', desc = 'horizontal' },
      { '<leader>tv',     '<cmd>ToggleTerm direction=vertical<cr>',   desc = 'vertical' },
      { '<leader>t<tab>', '<cmd>ToggleTerm direction=tab<cr>',        desc = 'tab' },
      { '<A-t>',          desc = 'toggle' },
    },
    opts = {
      open_mapping = '<A-t>',
    },
  },
  {
    'mrjones2014/smart-splits.nvim',
    keys = {
      { '<A-h>',   '<cmd>lua require("smart-splits").resize_left()<cr>',       desc = 'resize left' },
      { '<A-j>',   '<cmd>lua require("smart-splits").resize_down()<cr>',       desc = 'resize down' },
      { '<A-k>',   '<cmd>lua require("smart-splits").resize_up()<cr>',         desc = 'resize up' },
      { '<A-l>',   '<cmd>lua require("smart-splits").resize_right()<cr>',      desc = 'resize right' },
      { '<C-h>',   '<cmd>lua require("smart-splits").move_cursor_left()<cr>',  desc = 'move left' },
      { '<C-j>',   '<cmd>lua require("smart-splits").move_cursor_down()<cr>',  desc = 'move down' },
      { '<C-k>',   '<cmd>lua require("smart-splits").move_cursor_up()<cr>',    desc = 'move up' },
      { '<C-l>',   '<cmd>lua require("smart-splits").move_cursor_right()<cr>', desc = 'move right' },
      { '<C-\\>',  '<cmd>lua require("smart-splits").move_cursor_previous',    desc = 'previous' },
      { '<C-S-H>', '<cmd>lua require("smart-splits").swap_buf_left()<cr>',     desc = 'swap left' },
      { '<C-S-J>', '<cmd>lua require("smart-splits").swap_buf_down()<cr>',     desc = 'swap down' },
      { '<C-S-K>', '<cmd>lua require("smart-splits").swap_buf_up()<cr>',       desc = 'swap up' },
      { '<C-S-L>', '<cmd>lua require("smart-splits").swap_buf_right()<cr>',    desc = 'swap right' },
    },
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    cmd = 'Telescope',
    keys = {
      { '<leader>fg', '<cmd>Telescope live_grep<cr>',                          desc = 'grep' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>',                            desc = 'buffers' },
      { '<leader>fh', '<cmd>Telescope help_tags<CR>',                          desc = 'help tags' },
      { '<leader>fc', '<cmd>Telescope command_history<CR>',                    desc = 'command history' },
      { '<leader>fo', '<cmd>Telescope oldfiles<CR>',                           desc = 'old files' },
      { '<leader>ft', '<cmd>Telescope colorscheme<CR>',                        desc = 'colorschemes' },
      { '<leader>ff', '<cmd>Telescope find_files follow=true hidden=true<cr>', desc = 'find files' },
      { '<leader>fk', '<cmd>Telescope keymaps<cr>',                            desc = 'find keymaps' },
      { '<leader>f/', '<cmd>Telescope current_buffer_fuzzy_find<cr>',          desc = 'fuzzy find in buffer' },
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
    'Shatur/neovim-session-manager',
    keys = {
      { '<leader>sm', '<cmd>SessionManager<cr>',                          desc = 'open session manager' },
      { '<leader>ss', '<cmd>SessionManager save_current_session<cr>',     desc = 'save/create' },
      { '<leader>sl', '<cmd>SessionManager load_session<cr>',             desc = 'select session' },
      { '<leader>sg', '<cmd>SessionManager load_git_session<cr>',         desc = 'load git' },
      { '<leader>sc', '<cmd>SessionManager load_current_dir_session<cr>', desc = 'load cwd' },
      { '<leader>sd', '<cmd>SessionManager delete_session	<cr>',          desc = 'delete/select' },
    },
    cmd = 'SessionManager',
    opts = function ()
      local config = require('session_manager.config')
      return {
        autoload_mode = { config.AutoloadMode.GitSession, config.AutoloadMode.CurrentDir },
        autosave_only_in_session = true,
      }
    end,
  },
}
