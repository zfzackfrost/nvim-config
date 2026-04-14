require('mini.pairs').map_buf(0, 'i', "'", {
  action = 'closeopen',
  pair = "''",
  neigh_pattern = '[^<&%a\\].',
})
nvim.buf_create_user_command(0, 'DebugStart', function()
  vim.cmd.RustLsp('debug')
end, { force = true })
