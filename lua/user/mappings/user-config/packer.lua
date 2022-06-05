return function(prefix)
  local m = Utils.map
  prefix = prefix .. 'p'
  m.group_name('n', prefix, 'plugins-packer')
  m.map('n', prefix .. 's', '<Cmd>PackerSync<Cr>', { desc = 'Packer sync' })
  m.map('n', prefix .. 'i', '<Cmd>PackerStatus<Cr>', { desc = 'Packer info' })
end
