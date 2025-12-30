local iff = require('utils.func').iff
local comments = require('utils.vim.comments')

---GenModeline command function
local function gen_modeline()
  local ft = vim.bo.filetype
  local sw = vim.bo.shiftwidth
  local sts = vim.bo.softtabstop
  local ts = vim.bo.tabstop
  local et = vim.bo.expandtab

  local modeline_str = string.format(
    'vim: set %s ft=%s sw=%s ts=%s sts=%s', --
    iff(et, 'et', 'noet'),
    ft,
    tostring(sw),
    tostring(ts),
    tostring(sts)
  )
  nvim.win_set_cursor(0, { 1, 0 })
  nvim.put({ comments.format(modeline_str) }, 'l', true, true)
end

nvim.create_user_command('GenModeline', gen_modeline, {})
