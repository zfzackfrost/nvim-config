local M = {}
local tbl = require('user.utils.tbl')

M.WindowType = tbl.read_only({
  Floating = 'floating',
  Split = 'split',
})

M.OpenBufferMode = tbl.read_only({
  BufnrOption = 'bufnr_option',
  CreateEmpty = 'create_empty',
  CreateEmptyDestroyOnClose = 'create_empty_destroy_on_close',
})

M.DockEdge = tbl.read_only({
  Top = 'top',
  Bottom = 'bottom',
  Left = 'left',
  Right = 'right',
})

return M
