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
    on_init = function (client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
        return
      end

      local lazy = require('lazy.core.config')
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            lazy.spec.plugins['wezterm-types'].dir,
            lazy.spec.plugins['luvit-meta'].dir,
          },
        },
      })
    end,

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
              snippetSupport = true,
            },
          },
        },
      }
    ),
  },
}

for key, config in pairs(configs) do
  config = vim.tbl_deep_extend('force', default_config, config)
  configs[key] = config
end

setmetatable(configs, {
  __index = function () return default_config end,
})

return configs
