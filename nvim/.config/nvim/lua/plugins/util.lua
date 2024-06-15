return {
  {
    'lambdalisue/vim-suda',
  },
  {
    'natecraddock/sessions.nvim',
    opts = {
      events = { "WinEnter" },
      session_filepath = ".nvim/session",
      absolute = true,
    },
  },
  {
    'natecraddock/workspaces.nvim',
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
