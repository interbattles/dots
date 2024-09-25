return {
  {
    'klen/nvim-config-local',
    lazy = false,
    opts = {},
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = function ()
      local wk = require('which-key')
      wk.add({
        { '<leader>f',     group = 'find' },
        { '<leader>b',     group = 'buffer' },
        { '<leader>c',     group = 'code' },
        { '<leader>g',     group = 'git' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>x',     group = 'trouble' },
        { '<leader>s',     group = 'sessions' },
        { '<leader>l',     group = 'lazy' },
        { '<leader>t',     group = 'terminal' },
        { '<leader>q',     group = 'quit' },
      })
    end,
    keys = {
      {
        '<leader>?',
        function ()
          require('which-key').show({ global = false })
        end,
        desc = 'local keymaps',
      },
    },
  },
  {
    'cbochs/grapple.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = 'Grapple',
    event = 'VeryLazy',
    keys = {
      { '<C-t>', '<cmd>Grapple toggle<cr>',          desc = 'tag a file' },
      { ';',     '<cmd>Grapple toggle_tags<cr>',     desc = 'toggle tags menu' },

      { '<C-1>', '<cmd>Grapple select index=1<cr>',  desc = 'select first tag' },
      { '<C-2>', '<cmd>Grapple select index=2<cr>',  desc = 'select second tag' },
      { '<C-3>', '<cmd>Grapple select index=3<cr>',  desc = 'select third tag' },
      { '<C-4>', '<cmd>Grapple select index=4<cr>',  desc = 'select fourth tag' },

      { ',',     '<cmd>Grapple cycle_tags prev<cr>', desc = 'go to previous tag' },
      { '.',     '<cmd>Grapple cycle_tags next<cr>', desc = 'go to next tag' },
    },
    opts = {
      scope = 'git',
      icons = true,
      status = true,
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = vim.fn.argc(-1) == 0,
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
      { 'MunifTanjim/nui.nvim' },
    },
    cmd = 'Neotree',
    keys = {
      { '-', '<cmd>Neotree toggle<cr>' },
    },
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    },
  },
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'open neogit' },
    },
    dependencies = {
      { 'sindrets/diffview.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = true,
  },
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'diagnostics (trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'buffer diagnostics (trouble)',
      },
      {
        '<leader>cts',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'symbols',
      },
      {
        '<leader>ctl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'lsp definitions / references / ...',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'location list (trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'quickfix list (trouble)',
      },
    },
  },
  {
    'chrisbra/Colorizer',
    keys = {
      { '<leader>cc', '<cmd>ColorToggle<cr>', desc = 'toggle colorizer', noremap = true },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function () vim.fn['mkdp#util#install']() end,
  },
  {
    'kndndrj/nvim-dbee',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
    build = function ()
      require('dbee').install()
    end,
    config = function (_, opts)
      require('dbee').setup(opts)
    end,
  },
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    config = function ()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      -- dashboard.section.terminal.type = 'terminal'
      -- dashboard.section.terminal.command = 'lolcrab ~/.config/nvim/arts/dashboard.txt'
      -- dashboard.section.terminal.width = 69
      -- dashboard.section.terminal.height = 10

      local function entry(icon, desc, key, action)
        return dashboard.button(key, icon .. ' ' .. desc, '<cmd>' .. action .. '<cr>')
      end

      dashboard.section.buttons.val = {
        entry('', 'new file', 'e', 'ene | startinsert'),
        entry('󰦛', 'restore session', 's', 'SessionManager load_session'),
        entry('󰥨', 'find files', 'f', 'Telescope find_files'),
        entry('󱎫', 'recent files', 'r', 'Telescope oldfiles'),
        entry('󰅚', 'quit nvim', 'q', 'qa'),
      }

      dashboard.config.layout = {
        -- dashboard.section.terminal,
        -- { type = 'padding', val = 2 },
        dashboard.section.buttons,
        dashboard.section.footer,
      }

      alpha.setup(dashboard.opts)

      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'AlphaReady',
          callback = function ()
            require('lazy').show()
          end,
        })
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        desc = 'add alpha dashboard footer',
        once = true,
        callback = function ()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = '󰏋 loaded ' ..
              stats.loaded .. ' / 󱑥 ' .. stats.count .. ' plugins (' .. ms .. 'ms)'

          vim.cmd 'AlphaRedraw'
        end,
      })
    end,
  },

}
