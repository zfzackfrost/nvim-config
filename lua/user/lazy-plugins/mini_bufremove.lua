return function()
  require('mini.bufremove').setup({})

  local m = require('user.utils.map')
  m.map('n', { '<Space>bdd', '<Leader>c' }, function()
    require('mini.bufremove').delete()
  end, { desc = 'Close current buffer' })
end
