return {
  {
    'lambdalisue/vim-suda',
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = true
  },
  {
    'mrjones2014/smart-splits.nvim',
    init = function()
      vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)

      vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
      vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)

      vim.keymap.set('n', '<C-S-H>', require('smart-splits').swap_buf_left, { desc = 'swap left' })
      vim.keymap.set('n', '<C-S-J>', require('smart-splits').swap_buf_down, { desc = 'swap down' })
      vim.keymap.set('n', '<C-S-K>', require('smart-splits').swap_buf_up, { desc = 'swap up' })
      vim.keymap.set('n', '<C-S-L>', require('smart-splits').swap_buf_right, { desc = 'swap right' })
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'tiagovla/scope.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    opts = {
      defaults = {
        initial_mode = 'normal',
      },
    },
    config = function(_, opts)
      require('telescope').setup(opts)

      require('telescope').load_extension 'file_browser'
      require('telescope').load_extension 'scope'

      vim.keymap.set('n', '<leader>tg', '<cmd>Telescope live_grep<cr>', { noremap = true, desc = 'grep' })
      vim.keymap.set('n', '<leader>tf', '<cmd>Telescope file_browser<cr>', { noremap = true, desc = 'files' })
      vim.keymap.set('n', '<leader>tb', '<cmd>Telescope scope buffers<cr>', { noremap = true, desc = 'buffers' })
      vim.keymap.set('n', '<leader>ta', '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>',
        { noremap = true, desc = 'find all' })
      vim.keymap.set('n', '<leader>th', '<cmd>Telescope help_tags<CR>', { noremap = true, desc = 'help tags' })
      vim.keymap.set('n', '<leader>tc', '<cmd>Telescope command_history<CR>', { noremap = true, desc = 'command history' })
      vim.keymap.set('n', '<leader>to', '<cmd>Telescope oldfiles<CR>', { noremap = true, desc = 'old files' })
      vim.keymap.set('n', '<leader>tt', '<cmd>Telescope colorscheme<CR>', { noremap = true, desc = 'colorschemes' })
    end,
  },
}
