---@param direction "decrement"|"increment" Up or down
---@param mode "gnormal"|"gvisual"|"normal"|"visual" the mode
---@param group_name? string Group name string
---@return fun() # Manipulator function
local function manipulate(direction, mode, group_name)
  return function()
    require('dial.map').manipulate(direction, mode, group_name)
  end
end

return {
  'monaqa/dial.nvim',
  keys = {
    { '<C-z>', manipulate('increment', 'normal'), mode = 'n' },
    { '<C-x>', manipulate('decrement', 'normal'), mode = 'n' },
    { '<C-z>', manipulate('increment', 'visual'), mode = 'v' },
    { '<C-x>', manipulate('decrement', 'visual'), mode = 'v' },
  },
  config = function()
    require('config.dial')
  end,
}
