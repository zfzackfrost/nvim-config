local M = {}

M.restart = function()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd('edit')
end

M.setup = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = true,
  })

  require('user.lazy-plugins.lsp.installer')

  require('user.lazy-plugins.lsp.lightbulb').setup()

  require('user.lazy-plugins.lsp.client.rust_analyzer')
  require('user.lazy-plugins.lsp.client.sumneko_lua')
  require('user.lazy-plugins.lsp.client.taplo')
  require('user.lazy-plugins.lsp.client.yamlls')
  require('user.lazy-plugins.lsp.client.jsonls')
  require('user.lazy-plugins.lsp.client.clangd')
  require('user.lazy-plugins.lsp.client.cmake')
  require('user.lazy-plugins.lsp.client.null-ls')
end

return M
