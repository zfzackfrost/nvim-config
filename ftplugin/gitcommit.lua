autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    vim.wo.spell = true
    vim.wo.colorcolumn = '+1'
  end,
})
