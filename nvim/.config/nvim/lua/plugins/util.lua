return {
  {
    'lambdalisue/vim-suda',
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

      vim.keymap.set('n', '<leader>sh', require('smart-splits').swap_buf_left, { desc = "swap left" })
      vim.keymap.set('n', '<leader>sj', require('smart-splits').swap_buf_down, { desc = "swap down" })
      vim.keymap.set('n', '<leader>sk', require('smart-splits').swap_buf_up, { desc = "swap up" })
      vim.keymap.set('n', '<leader>sl', require('smart-splits').swap_buf_right, { desc = "swap right" })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", { noremap = true, desc = "grep" })
      vim.keymap.set("n", "<leader>tf", "<cmd>Telescope file_browser<cr>", { noremap = true, desc = "files" })
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "file_browser"
    end
  },
  {
    "tiagovla/scope.nvim",
    lazy = true,
    init = function()
      require("telescope").load_extension("scope")
      vim.keymap.set("n", "<leader>ts", "<cmd>Telescope scope buffers<cr>", { noremap = true, desc = "scope" })
      vim.keymap.set("n", "<leader>be", "<cmd>Telescope scope buffers<cr>", { noremap = true, desc = "explore buffers" })
    end
  },
}
