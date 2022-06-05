local match_buffer = require('user.utils.buffer.match')

local exclude = {
  filetype = {
    '^help$',
    '^qf$',
    '^starter$',
    '^NvimTree$',
    '^Trouble$',
    '^Telescope%w*$',
  },
  buftype = {
    '^terminal$',
  }
}

local function enable_cursorline()
  if match_buffer(0, {}, exclude) then
    vim.wo.cursorline = true
  else
    vim.wo.cursorline = false
  end
end

local function disable_cursorline()
  vim.wo.cursorline = false
end

local group = vim.api.nvim_create_augroup('user_cursorline', {})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = group,
  callback = vim.schedule_wrap(enable_cursorline),
})
vim.api.nvim_create_autocmd('WinLeave', {
  group = group,
  callback = disable_cursorline
})
