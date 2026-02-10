---GenModeline command function
---@param t vim.api.keyset.create_user_command.command_args
local function gen_modeline(t)
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
  modeline_str = cmt_format(modeline_str)

  local first_line = nvim.buf_get_lines(0, 0, 1, false)[1]
  local has_shebang = us.starts_with(first_line, '#!')
  local line_nr = iff(has_shebang, 1, 0)
  nvim.buf_set_lines(0, line_nr, line_nr, false, { modeline_str })

  if not t.bang then
    nvim.win_set_cursor(0, { line_nr + 1, 0 })
  end
end

-- `GenModeLine` - Generate mode line for current buffer; move cursor to modeline
-- `GenModeLine!` - Generate mode line for current buffer; don't move the cursor
nvim.create_user_command('GenModeline', gen_modeline, { bang = true })
