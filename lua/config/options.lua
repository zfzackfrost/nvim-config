vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.opt

opt.viewoptions = { 'folds', 'cursor' }
opt.formatexpr = "v:lua.require'conform'.formatexpr()"
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.lsp.foldexpr()'
opt.foldlevel = 99
opt.showmode = false
opt.clipboard = ''
opt.hidden = true
opt.laststatus = 3
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.number = true
opt.relativenumber = true

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
