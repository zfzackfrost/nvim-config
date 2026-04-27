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
autocmd('TermOpen', {
  callback = function()
    vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], {
      buf = 0,
    })
  end,
})

-- Map <Esc> to `nohlsearch` in normal mode
vim.keymap.set('n', '<Esc>', [[<Cmd>nohlsearch<Cr>]])

-- Expand snippet with <M-Cr>
vim.keymap.set('i', '<M-Cr>', function()
  require('luasnip').expand()
end, { silent = true })

local function smart_close()
  local all_wins = nvim.tabpage_list_wins(0)

  if #all_wins <= 1 then
    vim.notify("Can't close last window!", vim.log.levels.WARN)
    return
  end
  if vim.bo.modified then
    vim.notify("Can't close window with unsaved changes!", vim.log.levels.WARN)
    return
  end
  local n_normal_wins = 0
  for _, w in ipairs(all_wins) do
    local buf = nvim.win_get_buf(w)
    if vim.bo[buf].buftype == '' then
      n_normal_wins = n_normal_wins + 1
    end
  end
  if n_normal_wins <= 1 and vim.bo.buftype == '' then
    return
  end
  nvim.win_close(0, false)
end
vim.keymap.set('n', 'q', smart_close, {})
