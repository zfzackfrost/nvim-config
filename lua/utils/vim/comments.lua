local M = {}

---Extract the contents of a comment
---@param text string the complete text of the comment, and only the comment (i.e. no other code).
---@param commentstring string value of `commentstring` option. Defaults to the vim option
---@return string # the contents of the comment extracted from `text`.
function M.extract(text, commentstring)
  if commentstring == nil then
    commentstring = vim.bo.commentstring
  end

  local pattern = string.gsub(commentstring, '%s*%%s%s*', '(.*)')
  local m = string.match(text, pattern)
  if m ~= nil then
    return m
  end
  return ''
end

---Comment out each line in a string
---@param text string text to add comments to
---@param commentstring? string value of `commentstring` option. Defaults to the vim option
---@param remove_spaces? boolean remove leading and trailing spaces from the comment string
---@return string `text` with every line commented out
function M.format(text, commentstring, remove_spaces)
  local lines = vim.split(text, '\n', { plain = true })
  if commentstring == nil then
    commentstring = vim.bo.commentstring
  end
  if remove_spaces then
    commentstring = string.gsub(commentstring, '%s*%%s%s*', '%%s')
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
