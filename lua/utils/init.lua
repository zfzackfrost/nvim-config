local lazy = require('utils.lazy_require')

local function make_setter(path)
  local components = vim.split(path, '.', { plain = true })
  local c_start = vim.list_slice(components, 1, #components - 1)
  local c_last = components[#components]
  return function(module)
    local t = _G.utils
    for _, c in pairs(c_start) do
      t = t[c]
    end
    t[c_last] = module
  end
end

_G.utils = {
  ---@module "plenary.async"
  async = lazy.on_index('plenary.async', make_setter('async')),
  ---@module "utils.brace_expand"
  brace_expand = lazy.on_index('utils.brace_expand', make_setter('brace_expand')),
  mini = {
    ---@module 'utils.mini.splitjoin'
    splitjoin = lazy.on_index('utils.mini.splitjoin', make_setter('mini.splitjoin')),
  },
  vim = {
    ---@module 'utils.vim.cmd'
    cmd = lazy.on_index('utils.vim.cmd', make_setter('vim.cmd')),
    ---@module 'utils.vim.comments'
    comments = lazy.on_index('utils.vim.comments', make_setter('vim.comments')),
    ---@module 'utils.vim.map'
    map = lazy.on_index('utils.vim.map', make_setter('vim.map')),
    ---@module 'utils.vim.selection'
    selection = lazy.on_index('utils.vim.selection', make_setter('vim.selection')),
  },
  ---@module 'utils.fs'
  fs = lazy.on_index('utils.fs', make_setter('fs')),
  ---@module 'utils.func'
  func = lazy.on_index('utils.func', make_setter('func')),
  ---@module 'utils.str'
  str = lazy.on_index('utils.str', make_setter('str')),
  ---@module 'utils.validate'
  validate = lazy.on_index('utils.validate', make_setter('validate')),
}
return _G.utils
