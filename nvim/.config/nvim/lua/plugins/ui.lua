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
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin',
    },
    config = function()
      local highlights = require("catppuccin.groups.integrations.bufferline").get()
      require("bufferline").setup {
        highlights = highlights
      }
    end,
    init = function()
      vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { desc = "pick buffer" })
      vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineTogglePin<CR>", { desc = "pin buffer" })
      vim.keymap.set("n", "<leader>bdo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "delete other buffers" })
      vim.keymap.set("n", "<leader>bdl", "<Cmd>BufferLineCloseRight<CR>", { desc = "delete buffers to the right" })
      vim.keymap.set("n", "<leader>bdh", "<Cmd>BufferLineCloseLeft<CR>", { desc = "delete buffers to the left" })
      vim.keymap.set("n", "<leader>boe", "<cmd>BufferLineSortByExtension<cr>", { desc = "order by extension" })
      vim.keymap.set("n", "<leader>bod", "<cmd>BufferLineSortByDirectory<cr>", { desc = "order by directory" })
      vim.keymap.set("n", "<leader>b[", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer" })
      vim.keymap.set("n", "<leader>b]", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer" })
      vim.keymap.set("n", "<leader>b,", "<cmd>BufferLineMovePrev<cr>", { desc = "move buffer back" })
      vim.keymap.set("n", "<leader>b.", "<cmd>BufferLineMoveNext<cr>", { desc = "move buffer forward" })
    end
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
