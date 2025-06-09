local wk = require('which-key')
local prefix = '<leader>d'
wk.add({
  { prefix, group = 'test/debug' },
  {
    prefix .. 't',
    function()
      require('neotest').summary.toggle()
    end,
    desc = 'Tests summary',
  },
  {
    prefix .. 'r',
    function()
      require('neotest').run.run()
    end,
    desc = 'Run nearest test',
  },
  {
    prefix .. 'f',
    function()
      require('neotest').run.run(vim.fn.expand('%'))
    end,
    desc = 'Run tests in file',
  },
})
