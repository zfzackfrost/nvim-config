vim.opt.list = true
vim.opt.listchars = {}
vim.opt.listchars:append('space:⋅')
vim.opt.listchars:append('tab:> ')
vim.opt.listchars:append('eol:↴')

require('indent_blankline').setup({
  char_blankline = '│',
  char = '┃',
  disable_with_nolist = true,
})
