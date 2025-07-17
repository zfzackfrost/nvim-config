local wk = require('which-key')

wk.add({
  { '<leader>c', group = 'code' },
  { '<leader>cl', group = 'language' },
})

require('config.keymaps.code.language')
require('config.keymaps.code.gen')
require('config.keymaps.code.navigate')
