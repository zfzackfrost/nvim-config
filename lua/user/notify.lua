local notify = require('notify')
local diagnostic_icons = require('user.icons.diagnostic').icons

notify.setup({
  stages = 'slide',
  icons = {
    ERROR = diagnostic_icons.error.text,
    INFO = diagnostic_icons.info.text,
    WARN = diagnostic_icons.warn.text,
    TRACE = diagnostic_icons.hint.text,
  },
  timeout = 3000,
})
vim.notify = notify

-- table from lsp severity to vim severity.
local severity = {
  vim.log.levels.ERROR,
  vim.log.levels.WARN,
  vim.log.levels.INFO,
  vim.log.levels.DEBUG,
}
vim.lsp.handlers['window/showMessage'] = function(err, method, params, client_id)
  vim.notify(method.message, severity[params.type])
end
