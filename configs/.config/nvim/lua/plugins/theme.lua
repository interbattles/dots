return {
  {
    'roobert/palette.nvim',
    lazy = false,
    priority = 1000,
    config = function ()
      vim.cmd.source '~/.cache/matugen/colors.vim'

      require('palette').setup({
        palettes = {
          main = 'matugen',
        },

        italics = true,
        transparent_background = true,

        custom_palettes = {
          main = {
            matugen = vim.tbl_extend(
              'force',
              require('palette.generator').generate_colors(
                require('palette.colors').main['dark'],
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

      vim.cmd.colorscheme 'palette'
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
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
}
