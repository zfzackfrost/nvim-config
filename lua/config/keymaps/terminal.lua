local wk = require('which-key')
local prefix = '<leader>t'

wk.add({
  { prefix, group = 'terminal' },
  {
    prefix .. 't',
    function()
      Snacks.terminal.toggle()
    end,
    desc = 'Terminal toggle',
  },
})
