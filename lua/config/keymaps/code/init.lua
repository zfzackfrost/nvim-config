local wk = require('which-key')

wk.add({
  { '<leader>c', group = 'code' },
  { '<leader>cl', group = 'language' },
  {
    '<leader>cf',
    '<Cmd>Format<Cr>',
    desc = 'Format code',
  },
})

require('config.keymaps.code.language')
require('config.keymaps.code.gen')
require('config.keymaps.code.navigate')
