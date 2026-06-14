local wk = require('which-key')
local prefix = '<Bslash>'

wk.add({
  { prefix, group = 'flash' },
  {
    prefix .. '<Bslash>',
    function()
      require('flash').jump()
    end,
    mode = { 'n', 'x', 'o' },
    desc = 'Flash',
  },
  {
    prefix .. 't',
    function()
      require('flash').treesitter()
    end,
    mode = { 'n', 'x', 'o' },
    desc = 'Flash Treesitter',
  },
  {
    prefix .. 'r',
    function()
      require('flash').remote()
    end,
    mode = 'o',
    desc = 'Remote Flash',
  },
  {
    prefix .. 'R',
    function()
      require('flash').treesitter_search()
    end,
    mode = { 'o', 'x' },
    desc = 'Treesitter Search',
  },
  {
    prefix .. 's',
    function()
      require('flash').toggle()
    end,
    mode = { 'c' },
    desc = 'Toggle Flash Search',
  },
})
