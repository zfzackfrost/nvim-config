local m = Utils.map

_G.UserMap = _G.UserMap or {}
_G.UserMap.operator = _G.UserMap.operator or {}

local select_commands = {
  line = "'[V']",
  char = '`[v`]',
  block = m.tc('`[<C-v>`]'),
}
_G.UserMap.operator.replace_reg = function(mode)
  if mode ~= nil then
    local r = vim.v.register
    local regtype = vim.fn.getregtype(r)
    local lines = vim.fn.getreg(r, 1, true)
    vim.cmd('normal! ' .. select_commands[mode] .. '"_x')
    vim.api.nvim_put(lines, regtype, false, false)
  else
    vim.go.operatorfunc = 'v:lua.UserMap.operator.replace_reg'
    return 'g@'
  end
end

m.map('n', 'gr', 'v:lua.UserMap.operator.replace_reg()', { expr = true, desc = 'Replace with register' })
