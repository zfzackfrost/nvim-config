_G.augroup = vim.api.nvim_create_augroup
_G.autocmd = vim.api.nvim_create_autocmd

_G.nvim = {
  echo = vim.api.nvim_echo,
  feedkeys = vim.api.nvim_feedkeys,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  get_hl = vim.api.nvim_get_hl,
  set_hl = vim.api.nvim_set_hl,
  get_current_line = vim.api.nvim_get_current_line,
  set_current_line = vim.api.nvim_set_current_line,
  get_mark = vim.api.nvim_get_mark,
  get_mode = vim.api.nvim_get_mode,

  list_bufs = vim.api.list_bufs,
  get_current_buf = vim.api.nvim_get_current_buf,
  set_current_buf = vim.api.nvim_set_current_buf,
  buf_is_loaded = vim.api.nvim_buf_is_loaded,
  buf_is_valid = vim.api.nvim_buf_is_valid,
  buf_set_lines = vim.api.nvim_buf_set_lines,
  buf_get_lines = vim.api.nvim_buf_get_lines,
  buf_delete = vim.api.nvim_buf_delete,
  buf_set_extmark = vim.api.nvim_buf_set_extmark,
  create_buf = vim.api.nvim_create_buf,

  list_wins = vim.api.list_wins,
  get_current_win = vim.api.nvim_get_current_win,
  set_current_win = vim.api.nvim_set_current_win,

  list_tabs = vim.api.list_tabs,
  get_current_tabpage = vim.api.nvim_get_current_tabpage,
  set_current_tabpage = vim.api.nvim_set_current_tabpage,

  list_chans = vim.api.nvim_list_chans,

  list_uis = vim.api.nvim_uis,

  buf_create_user_command = vim.api.nvim_buf_create_user_command,
  create_user_command = vim.api.nvim_create_user_command,
}
