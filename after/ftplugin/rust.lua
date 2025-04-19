require('mini.pairs').map_buf(0, 'i', "'", {
  action = 'closeopen',
  pair = "''",
  neigh_pattern = '[^<&%a\\].',
})
