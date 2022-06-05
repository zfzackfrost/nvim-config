local M = {}

function M.setup()
  vim.fn.sign_define('LightBulbSign', { text = 'ﯦ', texthl = 'LightBulbSign' })
  require('nvim-lightbulb').setup({
    sign = {
      enabled = true,
      priority = 11,
    },
    autocmd = {
      enabled = true,
      events = { 'CursorHold', 'CursorHoldI', 'InsertEnter', 'InsertLeave', 'CursorMoved' },
    },
  })
end

return M
