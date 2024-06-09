return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'lua', 'vim', 'vimdoc', 'html', 'rust' },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
  },

  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
