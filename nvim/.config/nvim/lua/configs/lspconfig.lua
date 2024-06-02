require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require "lspconfig"

lspconfig.rust_analyzer.setup {}
lspconfig.lua_ls.setup {}
