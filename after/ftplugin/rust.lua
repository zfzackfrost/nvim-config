require('mini.pairs').map_buf(0, 'i', "'", {
  action = 'closeopen',
  pair = "''",
  neigh_pattern = '[^<&%a\\].',
})
vim.b.debug_start_impl = function()
  vim.cmd.RustLsp('debug')
end
