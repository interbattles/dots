local map = vim.api.nvim_set_keymap

-- Move to previous/next
map('n', '<A-,>', '<Plug>(cokeline-focus-prev)', { silent = true })
map('n', '<A-.>', '<Plug>(cokeline-focus-next)', { silent = true })
-- Re-order to previous/next
map('n', '<A-<>', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<A->>', '<Plug>(cokeline-switch-next)', { silent = true })
