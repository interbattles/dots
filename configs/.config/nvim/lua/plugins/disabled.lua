---@diagnostic disable-next-line:unused-local
local disabled = {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function ()
      require('catppuccin').setup({
        integrations = {
          cmp = true,
          gitsigns = true,
          treesitter = true,
          notify = true,
          diffview = true,
          barbar = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
        },
      })

      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function ()
      vim.g.barbar_auto_setup = false

      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }
      map('n', '<leader>b[', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<leader>b]', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      map('n', '<leader>b{', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<leader>b}', '<Cmd>BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      map('n', '<leader>b1', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<leader>b2', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<leader>b3', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<leader>b4', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<leader>b5', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<leader>b6', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<leader>b7', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<leader>b8', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<leader>b9', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<leader>b0', '<Cmd>BufferLast<CR>', opts)
      -- Pin/unpin buffer
      map('n', '<leader>bp', '<Cmd>BufferPin<CR>', opts)
      -- Close buffer
      map('n', '<leader>bq', '<Cmd>BufferClose<CR>', opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      map('n', '<leader>bp', '<Cmd>BufferPick<CR>', opts)
      -- Sort automatically by...
      map('n', '<leader>bob', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
      map('n', '<leader>bon', '<Cmd>BufferOrderByName<CR>', opts)
      map('n', '<leader>bod', '<Cmd>BufferOrderByDirectory<CR>', opts)
      map('n', '<leader>bol', '<Cmd>BufferOrderByLanguage<CR>', opts)
      map('n', '<leader>bow', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
    end,
    opts = {
      icons = {
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.WARN] = { enabled = true, icon = ' ' },
          [vim.diagnostic.severity.INFO] = { enabled = false },
          [vim.diagnostic.severity.HINT] = { enabled = true },
        },
      },
    },
    version = '^1.0.0',
  },
  {
    'nvim-tree/nvim-tree.lua',
    enabled = false,
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle explorer' },
    },
    config = function ()
      require('nvim-tree').setup {
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = false,
          update_root = true,
        },
      }
    end,
    init = function ()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'main',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'NeoTree' },
    },
    opts = {
      auto_restore_session_experimental = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
      },
      window = {
        position = 'right',
      },
    },
    config = function (_, opts)
      require('neo-tree').setup(opts)
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/noice.nvim',
    },
    opts = function ()
      return {
        options = {
          theme = 'tokyonight',
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
          lualine_c = {},
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
    init = function ()
      vim.o.laststatus = 3
    end,
  },

  {
    'goolord/alpha-nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      require 'alpha.term'

      -- math.randomseed(os.time())
      -- local arts = vim.api.nvim_list_runtime_paths()[1] .. "/arts"
      -- local dir = require 'plenary.scandir'.scan_dir(arts, { hidden = true, depth = 1 })
      -- local custom_art = dir[math.random(#dir)]
      -- vim.g.dir = dir

      -- dashboard.section.terminal.type = 'terminal'
      -- dashboard.section.terminal.command = "cat " .. custom_art
      -- dashboard.section.terminal.width = 32
      -- dashboard.section.terminal.height = 14

      dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
        dashboard.button('s', ' Session Lens', ':Telescope session-lens<CR>'),
        dashboard.button('f', '󰥨 Find Files', ':Telescope find_files<CR>'),
        dashboard.button('b', '󰌱 Browse Files', ':Telescope file_browser<CR>'),
        dashboard.button('d', ' Dotfiles', ':cd ~/dots | Oil<CR>'),
        dashboard.button('q', '󰅚 Quit NVIM', ':qa<CR>'),
      }

      dashboard.config.layout = {
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      }

      --{
      --  --"      |\\      _,,,---,,_            ",
      --  --"ZZZzz /,`.-'`'    -.  ;-;;,_        ",
      --  --"     |,4-  ) )-,_. ,\\ (  `'-'       ",
      --  --"    '---''(_/--'  `-'\\_)            ",
      --}
      alpha.setup(dashboard.opts)
    end,
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
          style = 'underscore',
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
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'files', noremap = true },
    },
    cmd = 'Oil',
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function (name, _)
          return vim.startswith(name, '.')
        end,
        is_always_hidden = function (name, _)
          return name == '..'
        end,
      },
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-->'] = { 'actions.select', opts = { vertical = true }, desc = 'open the entry in a vertical split' },
        ['<C-|>'] = { 'actions.select', opts = { horizontal = true }, desc = 'open the entry in a horizontal split' },
        ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'open the entry in new tab' },
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },
      use_default_keymaps = false,
    },
  },
   {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
      local harpoon = require('harpoon')
      harpoon:setup()

      -- this breaks the harpoon lualine plugin
      -- local function toggle()
      --   local harpoon_entries = harpoon:list()
      --   local current_path = vim.fn.expand('%:.')

      --   for i = 1, harpoon_entries:length() do
      --     local harpoon_entry = harpoon_entries:get(i)
      --     if not harpoon_entry then
      --       break
      --     end

      --     local harpoon_path = harpoon_entry.value
      --     if harpoon_path == current_path then
      --       harpoon_entries:remove_at(i)
      --       vim.notify('removed harpoon entry ' .. i)
      --       return
      --     end
      --   end
      --   harpoon_entries:add()
      --   vim.notify('added harpoon entry ')
      -- end

      vim.keymap.set('n', '<C-t>', function () harpoon:list():add() end)
      vim.keymap.set('n', ';', function () harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set('n', '<C-1>', function () harpoon:list():select(1) end)
      vim.keymap.set('n', '<C-2>', function () harpoon:list():select(2) end)
      vim.keymap.set('n', '<C-3>', function () harpoon:list():select(3) end)
      vim.keymap.set('n', '<C-4>', function () harpoon:list():select(4) end)

      vim.keymap.set('n', ',', function () harpoon:list():prev() end)
      vim.keymap.set('n', '.', function () harpoon:list():next() end)
    end,
  },
 
}

return {}
