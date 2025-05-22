vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

autocmd('BufWinEnter', {
  callback = function()
    vim.wo.spell = true
    return true
  end,
})
