require('config.lsp.attach').setup()
local servers = require('config.lsp.servers')
local all_servers = servers.all_servers()
vim.lsp.enable(all_servers, true)
for _, name in ipairs(all_servers) do
  vim.lsp.config(name, servers.get_opts(name))
end
