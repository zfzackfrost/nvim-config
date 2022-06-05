local M = {}
M.get_visual_selection = function()
  return vim.api.nvim_eval([[ getline("'<")[getpos("'<")[2]-1:getpos("'>")[2]-1] ]])
end
return M
