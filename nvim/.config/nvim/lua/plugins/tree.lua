return {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('nvim-tree').setup({})
    end,
}

-- return {
--     'nvim-neo-tree/neo-tree.nvim',
--     branch = 'v3.x',
--     dependencies = {
--         'nvim-lua/plenary.nvim',
--         'nvim-tree/nvim-web-devicons',
--         'MunifTanjim/nui.nvim',
--     },
--
--     config = function()
--         vim.g.loaded_netrw = 1
--         vim.g.loaded_netrwPlugin = 1
--     end,
-- }
