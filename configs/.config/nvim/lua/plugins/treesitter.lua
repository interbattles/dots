return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  build = ':TSUpdate',

  lazy = vim.fn.argc(-1) == 0,
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  keys = {
    { '<c-space>', desc = 'increment selection' },
    { '<bs>',      desc = 'decrement selection', mode = 'x' },
  },

  opts_extend = { 'ensure_installed' },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ensure_installed = {
      'bash',
      'fish',
      'diff',
      'jsdoc',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'luap',
      'regex',
      'typescript',
      'javascript',
      'rust',
      'markdown',
      'markdown_inline',
      'toml',
      'vim',
      'vimdoc',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
        goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
        goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
        goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
      },
    },
  },
  config = function (_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
  init = function ()
    vim.filetype.add({
      pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
    })
  end,
}
