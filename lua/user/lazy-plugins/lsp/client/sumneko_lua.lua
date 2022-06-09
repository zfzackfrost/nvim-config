local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local config = require('user.lazy-plugins.lsp.make_config')('sumneko_lua', 'Lua', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 15000,
        preloadFileSize = 5000,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}, {enable_format = false})

require('lspconfig').sumneko_lua.setup(config)
