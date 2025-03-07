local wk = require('which-key')
wk.add({
  { '<leader>T', group = 'test' },
  {
    '<leader>Tt',
    function()
      require('neotest').summary.toggle()
    end,
    desc = 'Tests summary',
  },
  {
    '<leader>Tr',
    function()
      require('neotest').run.run()
    end,
    desc = 'Run nearest test',
  },
  {
    '<leader>Tf',
    function()
      require('neotest').run.run(vim.fn.expand('%'))
    end,
    desc = 'Run tests in file',
  },
})
