local M = {}

M.signs = {
  { name = 'DiagnosticSignError', text = '', texthl = 'DiagnosticSignError' },
  { name = 'DiagnosticSignWarn', text = '', texthl = 'DiagnosticSignWarn' },
  { name = 'DiagnosticSignInfo', text = '', texthl = 'DiagnosticSignInfo' },
  { name = 'DiagnosticSignHint', text = '', texthl = 'DiagnosticSignHint' },
}

M.setup = function()
  vim.fn.sign_define(M.signs)
end

return M
