require('config.lsp.attach')
local servers = require('config.lsp.servers')
for _, name in ipairs(servers.all_servers()) do
  vim.lsp.config(name, servers.get_opts(name))
  vim.lsp.enable(name)
end
