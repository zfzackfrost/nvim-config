local function plugin_groups()
  local wk = require('which-key')
  wk.add({
    { 's', group = 'surround', mode = { 'n', 'x' } },
  })
end

local function load_keymaps()
  plugin_groups()
  require('config.keymaps.buffers')
  require('config.keymaps.code')
  require('config.keymaps.files')
  require('config.keymaps.list')
  require('config.keymaps.remap')
  require('config.keymaps.search')
  require('config.keymaps.tabs')
  require('config.keymaps.test')
  require('config.keymaps.neovim')
  require('config.keymaps.windows')
end

local augroup = vim.api.nvim_create_augroup('user_keymaps', {})
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  group = augroup,
  callback = load_keymaps,
})
