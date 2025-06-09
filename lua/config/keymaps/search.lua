local wk = require('which-key')

local prefix = '<leader>s'

wk.add({
  { '<Esc>', '<Cmd>nohlsearch<Cr>' },
  { prefix, group = 'search' },
  { '<leader><leader>', '<Cmd>Telescope find_files<Cr>', desc = 'Search for files' },
  { prefix .. 'r', '<Cmd>Telescope oldfiles<Cr>', desc = 'Search for recent files' },
  { prefix .. 'g', '<Cmd>GrugFar<Cr>', desc = 'Search by file contents (GrugFar)' },
  { prefix .. 'b', '<Cmd>Telescope buffers<Cr>', desc = 'Search for buffer' },
  { prefix .. 'h', '<Cmd>Telescope help_tags<Cr>', desc = 'Search for vim help' },
  { prefix .. 'm', '<Cmd>Telescope man_pages<Cr>', desc = 'Search linux manual' },
  { prefix .. 't', '<Cmd>Telescope builtin<Cr>', desc = 'Search for Telescope finder' },
})
