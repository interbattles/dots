return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function ()
      local path = '~/.cache/matugen/colors.vim'

      local load = function ()
        vim.cmd.source(path)
        local c = vim.g

        require('catppuccin').setup({
          transparent_background = true,
          color_overrides = {
            all = {},
            latte = {},
            frappe = {},
            macchiato = {},
            mocha = {
              text = c.on_surface,
              subtext1 = c.primary_fixed,
              subtext0 = c.secondary,
              overlay2 = c.tertiary,
              overlay1 = c.secondary_container,
              overlay0 = c.primary_container,
              surface2 = c.surface_container_highest,
              surface1 = c.surface_container_high,
              surface0 = c.surface_container,

              base = c.surface_container_low,
              mantle = c.surface_container_lowest,
              crust = c.surface,
            },
          },
        })
        -- vim.cmd.colorscheme 'catppuccin'
      end

      local handle = vim.uv.new_fs_event()
      if handle == nil then
        return
      end

      handle:start(path, {
          watch_entry = true,
          stat = false,
          recursive = false,
        },
        function (_, _, _)
          -- this is ugly but not as ugly as an extra 70ms startup time
          vim.schedule(function ()
            load()
            vim.cmd 'CatppuccinCompile'
          end)
        end)

      load()

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  -- {
  --   'RRethy/base16-nvim',
  --   config = function ()
  --     vim.cmd.source '~/.cache/matugen/colors.vim'

  --     local c = vim.g

  --     require('base16-colorscheme').setup {
  --       base00 = c.surface, base01 = c.surface_container_high, base02 = c.surface_bright, base03 = c.primary_container,
  --       -- base00 = '#16161D', base01 = '#2c313c', base02 = '#3e4451', base03 = '#6c7891',


  --       base04 = c.tertiary_container, base05 = c.primary, base06 = c.secondary_container, base07 = c.on_surface_variant,
  --       -- base04 = '#565c64', base05 = '#abb2bf', base06 = '#9a9bb3', base07 = '#c5c8e6',


  --       base08 = c.primary, base09 = c.secondary, base0A = c.tertiary, base0B = c.primary_fixed,
  --       -- base08 = '#e06c75', base09 = '#d19a66', base0A = '#e5c07b', base0B = '#98c379',


  --       base0C = c.secondary_fixed, base0D = c.tertiary_fixed, base0E = c.primary_fixed, base0F = c.primary_fixed,
  --       -- base0C = '#56b6c2', base0D = '#0184bc', base0E = '#c678dd', base0F = '#a06949',
  --     }
  --   end,
  -- },
  --  {
  --    'interbattles/m3gen.nvim',
  --    -- dir = '~/m3gen',
  --    -- dev = true,
  --    opts = function ()
  --      vim.cmd.source '~/.cache/matugen/colors.vim'
  --
  --      return {
  --        colors = {
  --          override = true,
  --          source_color = vim.g.source_color,
  --
  --          surface = vim.g.surface,
  --          container = vim.g.surface_container,
  --          primary = vim.g.primary,
  --          secondary = vim.g.secondary,
  --          tertiary = vim.g.tertiary,
  --        },
  --
  --        transparent_background = false,
  --      }
  --    end,
  --    init = function ()
  --      vim.cmd.colorscheme 'm3gen'
  --    end,
  --  },
}
