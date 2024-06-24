return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function()
      require('catppuccin').setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          diffview = true,
          barbar = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
        },
      })

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin',
    },
    config = function()
      local highlights = require('catppuccin.groups.integrations.bufferline').get()
      require('bufferline').setup {
        highlights = highlights,
      }
    end,
    init = function()
      vim.keymap.set('n', '<leader>bco', '<cmd>BufferLineCloseOthers<cr>', { desc = 'close others', noremap = true, })
      vim.keymap.set('n', '<leader>bch', '<cmd>BufferLineCloseLeft<cr>',
        { desc = 'close others on left', noremap = true, })
      vim.keymap.set('n', '<leader>bcl', '<cmd>BufferLineCloseRight<cr>',
        { desc = 'close others on right', noremap = true, })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin', },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'catppuccin',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          lualine_a = { 'mode', },
          lualine_b = { 'filename', 'branch', 'diagnostics', },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
          },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress', 'diff', },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = { 'filename', },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location', },
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
    init = function()
      vim.o.laststatus = 3
    end,
  },
  {
    'rcarriga/nvim-notify',
    -- opts = {
    --   render = 'compact',
    -- },
    config = function(_, opts)
      require('notify').setup(opts)
      vim.notify = require('notify')
    end,
  },
}
