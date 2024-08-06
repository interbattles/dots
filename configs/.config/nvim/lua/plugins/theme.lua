return {
  {
    'interbattles/m3gen.nvim',
    -- dir = '~/m3gen',
    -- dev = true,
    opts = function ()
      vim.cmd.source '~/.cache/matugen/colors.vim'

      return {
        colors = {
          override = true,
          source_color = vim.g.source_color,

          surface = vim.g.surface,
          container = vim.g.surface_container,
          primary = vim.g.primary,
          secondary = vim.g.secondary,
          tertiary = vim.g.tertiary,
        },

        transparent_background = true,
      }
    end,
    init = function ()
      vim.cmd.colorscheme 'm3gen'
    end,
  },
}
