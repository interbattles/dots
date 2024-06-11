-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add dracula
  { "Mofiqul/dracula.nvim" },
  --{
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "dracula",
  --  },
  --},

  {
    "sindrets/diffview.nvim",  -- optional - Diff integration
    dependencies = {
      "nvim-lua/plenary.nvim", -- required

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true
  },
  {
    "kyazdani42/nvim-web-devicons",
  },
}
