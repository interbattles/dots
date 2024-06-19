return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          diffview = true,
          barbar = true,
          telescope = {
            enabled = true,
            -- style = "nvchad"
          }
        }
      })

      vim.cmd.colorscheme "catppuccin"
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin' },
    lazy = false,
    config = true,
    opts = {
      options = {
        theme = 'catppuccin',
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {
          '%=', --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    },
    init = function()
      vim.o.laststatus = 2
      vim.opt.showtabline = 1
    end
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        render = "compact",
      })
      vim.notify = require("notify")
    end
  },
}
