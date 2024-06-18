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
    init = function()
      require("telescope").load_extension("scope")
    end
  },
}
