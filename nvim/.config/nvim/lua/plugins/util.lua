return {
  {
    'lambdalisue/vim-suda',
  },
  {
    'natecraddock/sessions.nvim',
    lazy = false,
    keys = {
      { "<leader>ss", "<cmd>SessionsSave<cr>", { desc = "Save session" } },
    },
    opts = {
      session_filepath = ".nvim/session",
      absolute = false,
    },
    config = function(_, opts)
      local sessions = require("sessions")
      sessions.setup(opts)
    end,
  },
  {
    'natecraddock/workspaces.nvim',
    keys = {
      { "<leader>we", "<cmd>Telescope workspaces<cr>", { desc = "Open Workspaces Explorer" } },
      { "<leader>ws", "<cmd>WorkspacesSyncDirs<cr>",   { desc = "Sync Workspaces Dirs" } },
    },
    config = function()
      require("workspaces").setup({
        hooks = {
          open_pre = {
            "SessionsStop",
            "silent %bdelete!",
          },
          open = {
            function()
              require("sessions").load(nil, { silent = true })
            end
          }
        },
      })
      require('telescope').load_extension("workspaces")
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
  }
}
