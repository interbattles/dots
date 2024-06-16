return {
  {
    'lambdalisue/vim-suda',
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      vim.keymap.set("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", { noremap = true, desc = "Live grep" })
      vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>", { noremap = true, desc = "Find files" })
      vim.keymap.set("n", "<leader>tb", "<cmd>Telescope file_browser<cr>", { noremap = true, desc = "File Browser" })
    end
  },
  {
    "tiagovla/scope.nvim",
    lazy = false,
    config = function()
      require('scope').setup {
        hooks = {
          pre_tab_leave = function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabLeavePre' })
          end,

          post_tab_enter = function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'ScopeTabEnterPost' })
          end,
        },
      }
    end,
    init = function()
      require("telescope").load_extension("scope")
    end
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        auto_session_last_session_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }

      vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>", { noremap = true, desc = "Save session" })
      vim.keymap.set("n", "<leader>sl", "<cmd>SessionRestore<cr>", { noremap = true, desc = "Load previous session" })
      vim.keymap.set("n", "<leader>se", require("auto-session.session-lens").search_session, {
        noremap = true,
        desc = "Session lens"
      })
    end,
  },
}
