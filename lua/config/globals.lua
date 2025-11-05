_G.augroup = vim.api.nvim_create_augroup
_G.autocmd = vim.api.nvim_create_autocmd

---Global nvim api aliases
_G.nvim = {
  clear_autocmds = vim.api.nvim_clear_autocmds,
  del_augroup_by_id = vim.api.nvim_del_augroup_by_id,
  del_augroup_by_name = vim.api.nvim_del_augroup_by_name,
  del_autocmd = vim.api.nvim_del_autocmd,
  exec_autocmds = vim.api.nvim_exec_autocmds,
  get_autocmds = vim.api.nvim_get_autocmds,

  exec2 = vim.api.nvim_exec2,
  paste = vim.api.nvim_paste,
  put = vim.api.nvim_put,
  input = vim.api.nvim_input,
  echo = vim.api.nvim_echo,
  feedkeys = vim.api.nvim_feedkeys,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  eval_statusline = vim.api.nvim_eval_statusline,
  create_namespace = vim.api.nvim_create_namespace,
  get_current_line = vim.api.nvim_get_current_line,
  set_current_line = vim.api.nvim_set_current_line,
  get_mode = vim.api.nvim_get_mode,
  get_keymap = vim.api.nvim_get_keymap,
  get_runtime_file = vim.api.nvim_get_runtime_file,
  open_term = vim.api.nvim_open_term,

  get_context = vim.api.nvim_get_context,
  load_context = vim.api.nvim_load_context,

  get_hl = vim.api.nvim_get_hl,
  set_hl = vim.api.nvim_set_hl,
  get_hl_id_by_name = vim.api.nvim_get_hl_id_by_name,
  get_hl_ns = vim.api.nvim_get_hl_ns,

  del_mark = vim.api.nvim_del_mark,
  get_mark = vim.api.nvim_get_mark,

  list_bufs = vim.api.nvim_list_bufs,
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
  chan_send = vim.api.nvim_chan_send,
  get_chan_info = vim.api.nvim_get_chan_info,

  buf_create_user_command = vim.api.nvim_buf_create_user_command,
  create_user_command = vim.api.nvim_create_user_command,
}
