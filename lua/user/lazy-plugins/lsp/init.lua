local M = {}

M.restart = function()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd('edit')
end

M.setup = function()
  require('nvim-lsp-installer').setup({})

  require('user.lazy-plugins.lsp.lightbulb').setup()

  require('user.lazy-plugins.lsp.client.rust_analyzer')
  require('user.lazy-plugins.lsp.client.sumneko_lua')
  require('user.lazy-plugins.lsp.client.null-ls')
end

return M
