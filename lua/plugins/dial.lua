---@param direction "decrement"|"increment" Up or down
---@param mode "gnormal"|"gvisual"|"normal"|"visual"|"insert" The mode
---@param group_name? string Group name string
---@return fun() # Manipulator function
local function manipulate(direction, mode, group_name)
  return function()
    local actual_mode = mode
    if mode == 'insert' then
      actual_mode = 'normal'
    end
    require('dial.map').manipulate(direction, actual_mode, group_name)
    if mode == 'insert' then
      vim.cmd('normal! i')
    end
  end
end

return {
  'monaqa/dial.nvim',
  keys = {
    { '<M-c>', manipulate('increment', 'normal', 'case'), mode = 'n' },
    { '<M-c>', manipulate('increment', 'visual', 'case'), mode = 'v' },
    { '<M-c>', manipulate('increment', 'insert', 'case'), mode = 'i' },
    { '<C-z>', manipulate('increment', 'normal'), mode = 'n' },
    { '<C-x>', manipulate('decrement', 'normal'), mode = 'n' },
    { '<C-z>', manipulate('increment', 'visual'), mode = 'v' },
    { '<C-x>', manipulate('decrement', 'visual'), mode = 'v' },
  },
  config = function()
    require('config.dial')
  end,
}
