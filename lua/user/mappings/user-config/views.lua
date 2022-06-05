return function(prefix)
  local m = Utils.map
  prefix = prefix .. 'v'

  m.group_name('n', prefix, 'views')
  m.map('n', prefix .. 'c', '<Cmd>CleanViewDir<Cr>', { desc = 'Clean view directory' })
end
