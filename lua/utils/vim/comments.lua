local M = {}

---Comment out each line in a string
---@param text string text to add comments to
---@param commentstring? string value of `commentstring` option. Defaults to the vim option
---@return string `text` with every line commented out
function M.commented_text(text, commentstring)
  local lines = vim.split(text, '\n', { plain = true })
  if commentstring == nil then
    commentstring = vim.bo.commentstring
  end
  local rv = ''
  for i = 1, #lines, 1 do
    local l = string.format(commentstring, lines[i])
    rv = rv .. l
    if i < #lines then
      rv = rv .. '\n'
    end
  end
  return rv
end

return M
