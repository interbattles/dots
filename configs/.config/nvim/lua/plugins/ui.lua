return {
  {
    'interbattles/matugen.nvim',
    config = function()
      local matugen = require('matugen')
      matugen.setup()
    end,
  },
  {
    'folke/noice.nvim',
    lazy = false,
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
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
      cmdline = {
        view = 'cmdline',
      },
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
      require('bufferline').setup {}
    end,
    init = function()
      vim.keymap.set('n', '[b', '<cmd>BufferLineCyclePrev<cr>', { desc = 'prev buffer', noremap = true })
      vim.keymap.set('n', ']b', '<cmd>BufferLineCycleNext<cr>', { desc = 'next buffer', noremap = true })
      vim.keymap.set('n', '[B', '<cmd>BufferLineMovePrev<cr>', { desc = 'move back', noremap = true })
      vim.keymap.set('n', ']B', '<cmd>BufferLineMoveNext<cr>', { desc = 'move forward', noremap = true })

      vim.keymap.set('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', { desc = 'close others', noremap = true })
      vim.keymap.set('n', '<leader>be', '<cmd>BufferLineSortByExtension<cr>',
        { desc = 'sort by extension', noremap = true })
      vim.keymap.set('n', '<leader>bd', '<cmd>BufferLineSortByDirectory<cr>',
        { desc = 'sort by directory', noremap = true })
      vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = 'pick buffer', noremap = true })
      vim.keymap.set('n', '<leader>bP', '<cmd>BufferLinePickClose<cr>', { desc = 'close picker', noremap = true })
      vim.keymap.set('n', '<leader>bc', '<cmd>BufferLineCloseLeft<cr>',
        { desc = 'close others on left', noremap = true })
      vim.keymap.set('n', '<leader>bC', '<cmd>BufferLineCloseRight<cr>',
        { desc = 'close others on right', noremap = true })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/noice.nvim',
    },
    opts = function()
      return {
        options = {
          theme = 'matugen-nvim',
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
          },
          lualine_x = {
            {
              function() return require('noice').api.status.mode.get() end, ---@diagnostic disable-line:undefined-field
              cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end, ---@diagnostic disable-line:undefined-field
            },
            {
              function() return require('noice').api.status.command.get() end, ---@diagnostic disable-line:undefined-field
              cond = function() return package.loaded['noice'] and require('noice').api.status.command.has() end, ---@diagnostic disable-line:undefined-field
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
      }
    end,
    init = function()
      vim.o.laststatus = 3
    end,
  },
}
