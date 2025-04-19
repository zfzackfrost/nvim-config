require('config.lsp.attach')
local servers = require('config.lsp.servers')
local lspconfig = require('lspconfig')
for _, name in ipairs(servers.all_servers()) do
  lspconfig[name].setup(servers.get_opts(name))
end
