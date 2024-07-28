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
    'goolord/alpha-nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    config = function ()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      require 'alpha.term'

      dashboard.section.terminal.type = 'terminal'
      dashboard.section.terminal.command = 'lolcrab ~/.config/nvim/arts/dashboard.txt'
      dashboard.section.terminal.width = 69
      dashboard.section.terminal.height = 10

      local function entry(icon, desc, key, action)
        return dashboard.button(key, icon .. ' ' .. desc, '<cmd>' .. action .. '<cr>')
      end

      dashboard.section.buttons.val = {
        entry('', 'New File', 'e', 'ene | startinsert'),
        (require('auto-session').session_exists_for_cwd()
          and entry('󰦛', 'Restore Session', 'r', 'SessionRestore')
          or entry('', 'Session Lens', 's', 'Telescope session-lens')),
        entry('󰥨', 'Find Files', 'f', 'Telescope find_files'),
        entry('󰌱', 'Browse Files', 'b', 'Telescope file_browser'),
        entry('', 'Dotfiles', 'd', 'cd ~/dots | Oil'),
        entry('󰅚', 'Quit NVIM', 'q', 'qa'),
      }

      dashboard.config.layout = {
        dashboard.section.terminal,
        { type = 'padding', val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      }

      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        desc = 'add alpha dashboard footer',
        once = true,
        callback = function ()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '󰏋 Loaded ' ..
              stats.loaded .. ' / 󱑥 ' .. stats.count .. ' plugins (' .. ms .. 'ms)'

          vim.cmd [[AlphaRedraw]]
        end,
      })
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    lazy = true,
    enabled = false,
    event = 'VimEnter',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
    },
    opts = function ()
      local function entry(icon, desc, key, action)
        return {
          key = key,
          desc = desc,
          action = action,
          icon = icon .. ' ',
          icon_hl = 'SpecialKey',
          desc_hl = 'Normal',
          key_hl = 'SpecialKey',
          key_format = ' [%s]',
        }
      end

      return {
        theme = 'doom',
        preview = {
          command = 'lolcrab',
          file_path = '~/.config/nvim/arts/dashboard.txt',
          file_width = 69,
          file_height = 10,
        },
        config = {
          center = {
            entry('', 'New File', 'e', 'ene | startinsert'),
            (require('auto-session').session_exists_for_cwd()
              and entry('󰦛', 'Restore Session', 'r', 'SessionRestore')
              or entry('', 'Session Lens', 's', 'Telescope session-lens')),
            entry('󰥨', 'Find Files', 'f', 'Telescope find_files'),
            entry('󰌱', 'Browse Files', 'b', 'Telescope file_browser'),
            entry('', 'Dotfiles', 'd', 'cd ~/dots | Oil'),
            entry('󰅚', 'Quit NVIM', 'q', 'qa'),
          },
          footer = function ()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '󰏋 Loaded ' .. stats.loaded .. ' / 󱑥 ' .. stats.count .. ' plugins (' .. ms .. 'ms)' }
          end,
        },
      }
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
