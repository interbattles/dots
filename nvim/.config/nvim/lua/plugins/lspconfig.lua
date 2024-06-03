return {
    'neovim/nvim-lspconfig',

    dependencies = {
        'williamboman/mason.nvim',
    },

    config = function()
        local lspconfig = require('lspconfig')
        local mason = require('mason')

        mason.setup()

        lspconfig.rust_analyzer.setup({})
        lspconfig.lua_ls.setup({})
        lspconfig.taplo.setup({})
    end,
}
