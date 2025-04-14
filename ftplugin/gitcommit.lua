autocmd('BufWinEnter', {
  callback = function()
    vim.wo.spell = true
    return true
  end,
})
