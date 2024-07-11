return {
  -- {
  --   '~/pywal16.nvim',
  --   config = function()
  --     vim.cmd('colorscheme pywal16')

  --     -- local colors = require('pywal16.core').get_colors()
  --     -- local highlights = {
  --     --   NeogitBranch = {},
  --     --   NeogitRemote = {},
  --     --   NeogitHunkHeader = {},
  --     --   NeogitHunkHeaderHighlight = {},
  --     --   NeogitDiffContextHighlight = {},
  --     --   NeogitDiffDeleteHighlight = {},
  --     --   NeogitDiffAddHighlight = {},
  --     -- }
  --     -- for group, properties in pairs(highlights) do
  --     --   vim.api.nvim_set_hl(0, group, properties)
  --     -- end
  --   end,
  -- },
  {
    'AlphaTechnolog/pywal.nvim',
    config = true,
    init = function()
      vim.cmd 'colorscheme pywal'
    end,
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      views = {
        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      --'catppuccin',
    },
    config = function()
      -- local highlights = require('catppuccin.groups.integrations.bufferline').get()
      require('bufferline').setup {
        -- highlights = highlights,
      }
    end,
    init = function()
      vim.keymap.set('n', '<leader>bco', '<cmd>BufferLineCloseOthers<cr>', { desc = 'close others', noremap = true })
      vim.keymap.set('n', '<leader>bch', '<cmd>BufferLineCloseLeft<cr>',
        { desc = 'close others on left', noremap = true })
      vim.keymap.set('n', '<leader>bcl', '<cmd>BufferLineCloseRight<cr>',
        { desc = 'close others on right', noremap = true })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/noice.nvim',
    },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'pywal-nvim',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          lualine_a = {
            {
              'mode',
              icons_enabled = true,
            },
          },
          lualine_b = { 'filename', 'branch', 'diagnostics' },
          lualine_c = {
            '%=', --[[ add your center compoentnts here in place of this comment ]]
          },
          lualine_x = {
            {
              require('noice').api.statusline.mode.get,
              cond = require('noice').api.statusline.mode.has,
              color = { fg = '#ff9e64' },
            },
          },
          lualine_y = { 'filetype', 'progress', 'diff' },
          lualine_z = {},
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
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      })
    end,
    init = function()
      vim.o.laststatus = 3
    end,
  },
}
