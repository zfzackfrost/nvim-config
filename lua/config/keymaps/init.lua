local function extra_groups()
  local wk = require('which-key')
  wk.add({
    { 's', group = 'surround', mode = { 'n', 'x' } },
  })
end

local function load_keymaps()
  extra_groups()
  require('config.keymaps.buffers')
  require('config.keymaps.code')
  require('config.keymaps.files')
  require('config.keymaps.git')
  require('config.keymaps.list')
  require('config.keymaps.neovim')
  require('config.keymaps.remap')
  require('config.keymaps.search')
  require('config.keymaps.tabs')
  require('config.keymaps.terminal')
  require('config.keymaps.test')
  require('config.keymaps.toggle')
  require('config.keymaps.windows')
end

local group = augroup('user_keymaps', {})
autocmd('User', {
  pattern = 'VeryLazy',
  group = group,
  callback = load_keymaps,
})
