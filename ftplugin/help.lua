autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    local winid = nvim.get_current_win()
    vim.wo[winid][0].wrap = true
    return true -- Delete autocmd
  end,
})
