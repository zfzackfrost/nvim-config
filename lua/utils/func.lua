local M = {}

---If function
---@param choose_a boolean Return value `a`?
---@param a any first value
---@param b any second value
---@return any # `a` if `choose_a` is `true`. Otherwise `b`.
function M.iff(choose_a, a, b)
  if choose_a then
    return a
  end
  return b
end

return M
