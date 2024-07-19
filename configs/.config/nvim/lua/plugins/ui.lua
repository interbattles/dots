return {
  {
    "roobert/palette.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd [[ source ~/.cache/matugen/colors.vim ]]

      require("palette").setup({
        palettes = {
          main = "team_zissou",
        },

        italics = true,
        transparent_background = true,

        custom_palettes = {
          main = {
            -- a blue theme, based off the built-in dark palette
            team_zissou = vim.tbl_extend(
              "force",
              require("palette.generator").generate_colors(
                require("palette.colors").main["dark"],
                vim.g.source_color
              ),
              {
                -- override background and cursor-line
                color0 = vim.g.surface,
                color1 = vim.g.surface_container,
                -- override most prominent colors (strings, etc.)
                color6 = vim.g.primary,
                color7 = vim.g.secondary,
                color8 = vim.g.tertiary,
              }
            ),
          },
        },
      })

      vim.cmd [[ colorscheme palette ]]
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
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        show_close_icon = false,
        always_show_bufferline = false,
        indicator = {
          style = 'underscore'
        },
     },
    },
    config = function (_, opts)
      require('bufferline').setup(opts)
    end,
    init = function ()
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
      vim.keymap.set('n', '<leader>bC', '<cmd>BufferLineCloseLeft<cr>',
        { desc = 'close others on left', noremap = true })
      vim.keymap.set('n', '<leader>bc', '<cmd>BufferLineCloseRight<cr>',
        { desc = 'close others on right', noremap = true })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/noice.nvim',
    },
    opts = function ()
      return {
        options = {
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
          lualine_c = { '%=' },
          lualine_x = {
            {
              function () return require('noice').api.status.mode.get() end, ---@diagnostic disable-line:undefined-field
              cond = function () return package.loaded['noice'] and require('noice').api.status.mode.has() end, ---@diagnostic disable-line:undefined-field
            },
            {
              function () return require('noice').api.status.command.get() end, ---@diagnostic disable-line:undefined-field
              cond = function () return package.loaded['noice'] and require('noice').api.status.command.has() end, ---@diagnostic disable-line:undefined-field
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
  },
}
