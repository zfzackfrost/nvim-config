vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.o.viewoptions = 'folds,cursor'
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.o.foldlevel = 99
vim.o.showmode = false
vim.o.clipboard = ''
vim.o.hidden = true
vim.o.laststatus = 3
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true

vim.o.foldmethod = 'expr'
-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Diagnostic signs
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵',
    },
  },
})

-- Filetype commentstring
do
  local get_option = vim.filetype.get_option
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.filetype.get_option = function(filetype, option)
    return option == 'commentstring' and require('ts_context_commentstring.internal').calculate_commentstring()
      or get_option(filetype, option)
  end
end
