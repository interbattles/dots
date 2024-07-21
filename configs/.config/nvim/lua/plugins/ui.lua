return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/noice.nvim',
    },
    opts = function ()
      vim.cmd [[ source ~/.cache/matugen/colors.vim ]]
      local background = vim.g.alpha < 1 and 'NONE' or vim.g.surface_variant
      local theme = {
        normal = {
          a = { bg = vim.g.primary_container, fg = vim.g.on_primary_container, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
        insert = {
          a = { bg = vim.g.secondary_container, fg = vim.g.on_secondary_container, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
        visual = {
          a = { bg = vim.g.tertiary_container, fg = vim.g.on_tertiary_container, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
        replace = {
          a = { bg = vim.g.secondary_container, fg = vim.g.on_secondary_container, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
        command = {
          a = { bg = vim.g.secondary_container, fg = vim.g.on_secondary_container, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
        inactive = {
          a = { bg = vim.g.surface_container, fg = vim.g.on_surface, gui = 'bold' },
          b = { bg = vim.g.surface_container, fg = vim.g.on_surface },
          c = { bg = background, fg = vim.g.on_surface },
        },
      }

      require('grapple').statusline()
      return {
        options = {
          theme = theme,
          component_separators = '',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              'mode',
              icons_enabled = true,
            },
          },
          lualine_b = { 'filename', 'branch', 'diagnostics' },
          lualine_c = { '%=', 'grapple' },
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
        tabline = {
          lualine_a = {
            {
              'filename',
              file_status = false,
              icon = '',
            },
          },
          lualine_b = {
            {
              'buffers',
              mode = 0,

              symbols = {
                modified = ' ●',
                alternate_file = '',
                directory = '',
              },
            },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {
            'tabs',
          },
        },
        winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {},

        },
        extensions = {},
      }
    end,
  },
}
