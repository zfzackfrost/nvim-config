vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    local winid = nvim.get_current_win()
    vim.wo[winid][0].spell = true
  end,
})
