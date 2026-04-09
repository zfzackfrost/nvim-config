local m = utils.vim.map

-- Disable tmux prefix key
m.disable_map('<C-a>')

-- Force `mini.surround` mappings to show with `which-key`
vim.keymap.set({ 'n', 'v' }, 's', function()
  require('which-key').show({
    keys = 's',
  })
end)

-- Map <Esc><Esc> to `<C-\><C-n>` in terminal mode
vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]])

-- Map <Esc> to `nohlsearch` in normal mode
vim.keymap.set('n', '<Esc>', [[<Cmd>nohlsearch<Cr>]])

-- Expand snippet with <M-Cr>
vim.keymap.set('i', '<M-Cr>', function()
  require('luasnip').expand()
end, { silent = true })

local function smart_close()
  local buftype = vim.bo.buftype
  if buftype == '' then
    return
  end
  local win_count = #nvim.list_wins()
  if win_count <= 1 then
    vim.notify("Can't close last window!", vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then
    vim.notify("Can't close window with unsaved changes!", vim.log.levels.WARN)
    return
  end
  nvim.win_close(0, false)
end
vim.keymap.set('n', 'q', smart_close, {})
