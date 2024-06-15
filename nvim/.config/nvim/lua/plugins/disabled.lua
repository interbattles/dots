return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
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
        position = "right"
      }
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
  },
  {
    'rmagatti/auto-session',
    enabled = false,
    lazy = false,
    keys = {
      { "<leader>ss", "<cmd>SessionSave<cr>",    desc = "Save session" },
      { "<leader>sl", "<cmd>SessionRestore<cr>", desc = "Load previous session" },
    },
    config = function()
      local function restore_nvim_tree()
        require("nvim-tree.api").tree.open({ focus = false })
      end

      require('auto-session').setup {
        auto_session_last_session_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        --         post_restore_cmds = { restore_nvim_tree },
        session_lens = {
          buftypes_to_ignore = {},
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }

      vim.keymap.set("n", "<leader>se", require("auto-session.session-lens").search_session, {
        noremap = true,
      })
    end,
  },
}
