return {
	config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "vim", "vimdoc", "html", "rust" },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },  
        })
    end,
}
