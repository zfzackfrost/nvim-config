autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    local winid = nvim.get_current_win()
    vim.wo[winid][0].spell = true
    vim.wo[winid][0].colorcolumn = '+1'
  end,
})
