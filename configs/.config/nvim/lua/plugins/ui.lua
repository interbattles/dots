return {
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'cbochs/grapple.nvim' },
    },
    opts = function ()
      vim.cmd.source '~/.cache/matugen/colors.vim'

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
          lualine_b = { 'branch', 'diagnostics' },
          lualine_c = { '%=', 'grapple' },
          lualine_x = {},
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
              function ()
                local bufs = vim.fn.getbufinfo({ buflisted = 1 })
                local currentBuf = vim.api.nvim_get_current_buf()

                local currentIdx = 1
                for i, x in pairs(bufs) do
                  if x.bufnr == currentBuf then
                    currentIdx = i
                  end
                end

                return currentIdx .. '/' .. #bufs
              end,
              icon = '',
            },
            {
              'filename',
            },
          },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'tabs' },
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
