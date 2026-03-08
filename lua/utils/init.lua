local lazy = require('utils.lazy_require')

return {
  mini = {
    ---@module 'utils.mini.splitjoin'
    splitjoin = lazy.on_exported_call('utils.mini.splitjoin'),
  },
  vim = {
    ---@module 'utils.vim.cmd'
    cmd = lazy.on_exported_call('utils.vim.cmd'),
    ---@module 'utils.vim.comments'
    comments = lazy.on_exported_call('utils.vim.comments'),
    ---@module 'utils.vim.map'
    map = lazy.on_exported_call('utils.vim.map'),
    ---@module 'utils.vim.selection'
    selection = lazy.on_exported_call('utils.vim.selection'),
  },
  ---@module 'utils.func'
  func = lazy.on_exported_call('utils.func'),
  ---@module 'utils.str'
  str = lazy.on_exported_call('utils.str'),
  ---@module 'utils.validate'
  validate = lazy.on_exported_call('utils.validate'),
}
