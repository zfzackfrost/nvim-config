local m = utils.vim.map
local prefix = '<Bslash>'

---@type wk.Icon
local flash_icon = {
  icon = '󱐋',
  color = 'yellow',
}

m.add_with_icon({
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
}, flash_icon)
