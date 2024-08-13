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
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function ()
      local opts = {
        theme = 'doom',
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = {},
          center = {
            { action = 'ene | startinsert', desc = ' new file', icon = ' ', key = 'e' },
            { action = 'Telescope find_files', desc = ' find file', icon = ' ', key = 'f' },
            { action = 'Telescope oldfiles', desc = ' recent files', icon = ' ', key = 'r' },
            { action = 'SessionManager load_session', desc = ' restore session', icon = ' ', key = 's' },
            { action = 'qa', desc = ' quit', icon = ' ', key = 'q' },
          },
          footer = function ()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '󰒲 lazy.nvim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
        button.key_format = '  %s'
        button.key_format = string.gsub(button.key, '<space>', '   SPC ')
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function ()
            require('lazy').show()
          end,
        })
      end

      return opts
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
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    lazy = false,
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'ms-jpq/coq.artifacts',  branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' },
    },
    init = function ()
      vim.g.coq_settings = {
        auto_start = true,
        display = {
          ghost_text = {
            context = { '', '' },
          },
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      on_attach = function (buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map('n', ']h', function () gs.nav_hunk('next') end, 'next hunk')
        map('n', '[h', function () gs.nav_hunk('prev') end, 'prev hunk')
        map('n', ']H', function () gs.nav_hunk('last') end, 'last hunk')
        map('n', '[H', function () gs.nav_hunk('first') end, 'first hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'stage hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'reset hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'stage buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'undo stage hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'reset buffer')
        map('n', '<leader>ghp', gs.preview_hunk_inline, 'preview hunk inline')
        map('n', '<leader>ghb', function () gs.blame_line({ full = true }) end, 'blame line')
        map('n', '<leader>ghd', gs.diffthis, 'diff this')
        map('n', '<leader>ghD', function () gs.diffthis('~') end, 'diff this ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'gitsigns select hunk')
      end,
    },
  },
  {
    'echasnovski/mini.files',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      { '-', '<cmd>lua require("mini.files").open()<cr>', desc = 'files' },
    },
    opts = {
      mappings = {
        close       = 'q',
        go_in       = '',
        go_in_plus  = '<CR>',
        go_out      = '-',
        go_out_plus = '_',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
    },
    config = function (_, opts)
      local MiniFiles = require('mini.files')
      MiniFiles.setup(opts)

      local files_set_cwd = function ()
        local cur_entry_path = MiniFiles.get_fs_entry().path
        local cur_directory = vim.fs.dirname(cur_entry_path)
        vim.fn.chdir(cur_directory)
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function (args)
          vim.keymap.set('n', 'g~', files_set_cwd, { buffer = args.data.buf_id, desc = ':cd mini.files dir' })
        end,
      })

      local map_split = function (buf_id, lhs, direction)
        local rhs = function ()
          -- Make new window and set it as target
          local new_target_window
          vim.api.nvim_win_call(MiniFiles.get_target_window() --[[@as number]], function ()
            vim.cmd(direction .. ' split')
            new_target_window = vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target_window)
        end

        local desc = 'split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function (args)
          local buf_id = args.data.buf_id
          -- Tweak keys to your liking
          map_split(buf_id, 'gs', 'belowright horizontal')
          map_split(buf_id, 'gv', 'belowright vertical')
        end,
      })
    end,
  },

}

return {}
