local default_config = {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
  ),
  flags = { debounce_text_changes = 200 },
}

local configs = {
  lua_ls = {
    settings = {
      Lua = {
        format = {
          enable = true,
        },
      },
    },
  },

  cssls = {
    capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = true
            }
          }
        }
      }
    ),
  }
}

for key, config in pairs(configs) do
  config = vim.tbl_deep_extend('force', default_config, config)
  configs[key] = config
end

setmetatable(configs, {
  __index = function() return default_config end,
})

return configs
