local wk = require('which-key')
wk.add({
  { '<leader>s', group = 'search' },
  { '<Esc>', '<Cmd>nohlsearch<Cr>' },
  { '<leader><Space>', '<Cmd>Telescope find_files<Cr>', desc = 'Search for files' },
  { '<leader>sr', '<Cmd>Telescope oldfiles<Cr>', desc = 'Search for recent files' },
  { '<leader>sg', '<Cmd>Telescope live_grep<Cr>', desc = 'Search file contents' },
  { '<leader>sb', '<Cmd>Telescope buffers<Cr>', desc = 'Search for buffer' },
  { '<leader>sh', '<Cmd>Telescope help_tags<Cr>', desc = 'Search for vim help' },
  { '<leader>sm', '<Cmd>Telescope man_pages<Cr>', desc = 'Search linux manual' },
})
