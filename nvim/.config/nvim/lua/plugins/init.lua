return {
	{
    		"williamboman/mason.nvim",
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				automatic_installation = true
			}
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				require "configs.lspconfig"
			end,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
    		build = ":TSUpdate",
		config = function()
      			require "configs.treesitter"
    		end,
  	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
	},
	"mfussenegger/nvim-lint",
	"mhartington/formatter.nvim",
}
