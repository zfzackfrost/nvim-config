vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

autocmd('BufWinEnter', {
  buffer = 0,
  callback = function()
    vim.wo.spell = true
  end,
})
