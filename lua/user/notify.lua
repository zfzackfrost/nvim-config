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

-- Map LSP severity to vim.log.levels
local LSP_TO_LOG_LVL = {
  vim.log.levels.ERROR,
  vim.log.levels.WARN,
  vim.log.levels.INFO,
  vim.log.levels.DEBUG,
}
vim.lsp.handlers['window/showMessage'] = function(_, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  ---@diagnostic disable-next-line: redundant-parameter
  vim.notify(result.message, LSP_TO_LOG_LVL[ctx.type], {
    title = 'LSP: ' .. client.name,
  })
end
