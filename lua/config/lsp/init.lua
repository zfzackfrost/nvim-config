require('config.lsp.attach')
require('config.lsp.progress')
local servers = require('config.lsp.servers')

local lspconfig = require('lspconfig')
for _, name in ipairs(servers.all_servers()) do
  lspconfig[name].setup(servers.get_opts(name))
end
