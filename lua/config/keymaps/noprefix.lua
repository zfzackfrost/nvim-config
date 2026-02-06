local m = require('utils.vim.map')

-- Disable tmux prefix key
m.disable_map('<C-a>')

-- Force `mini.surround` mappings to show with `which-key`
vim.keymap.set({ 'n', 'v' }, 's', function()
  require('which-key').show({
    keys = 's',
  })
end)

-- Map <Esc> to `nohlsearch` in normal mode
vim.keymap.set('n', '<Esc>', [[<Cmd>nohlsearch<Cr>]])
vim.keymap.set('i', '<M-Cr>', function()
  require('luasnip').expand()
end, { silent = true })
