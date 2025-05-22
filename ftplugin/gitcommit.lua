autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    vim.wo.spell = true
  end,
})
