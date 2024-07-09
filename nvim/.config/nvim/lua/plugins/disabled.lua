---@diagnostic disable-next-line:unused-local
local disabled = {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function()
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
    init = function()
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
    config = function()
      require('nvim-tree').setup {
        sync_root_with_cwd = true,
        update_focused_file = {
          enable = false,
          update_root = true,
        },
      }
    end,
    init = function()
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
    config = function(_, opts)
      require('neo-tree').setup(opts)
    end,
  },
}

return {}
