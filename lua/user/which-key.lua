local wk = require('which-key')

---@diagnostic disable-next-line: redundant-parameter
wk.setup({
  operators = {
    gc = '',
    gb = '',
    gr = '',
    sa = '',
  },
  key_labels = {
    ['<Space>'] = 'SPC',
    ['<Cr>'] = 'RET',
    ['<Tab>'] = 'TAB',
    ['<NL>'] = '<C-J>',
  },
  window = {
    winblend = 5,
    border = "single",
  },
})
