---GenModeline command function
local function gen_modeline()
  local iff = require('utils.func').iff
  local us = require('utils.str')
  local cmt_format = require('utils.vim.comments').format

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
  local first_line = nvim.get_current_line()
  local has_shebang = us.starts_with(first_line, '#!')
  nvim.put({ cmt_format(modeline_str) }, 'l', has_shebang, true)
end

nvim.create_user_command('GenModeline', gen_modeline, {})
