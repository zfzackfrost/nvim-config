local M = {}

---@param value any value to check
---@return boolean # `true` if `value` is `nil`. Otherwise, `false`.
function M.is_nil(value)
  return value == nil
end

---@param value any value to check
---@return boolean # `true` if `value` is a `boolean`. Otherwise, `false`.
function M.is_bool(value)
  return type(value) == 'boolean'
end

---@param value any value to check
---@return boolean # `true` if `value` is a `number`. Otherwise, `false`.
function M.is_number(value)
  return type(value) == 'number'
end

---@param value any value to check
---@return boolean # `true` if `value` is a `string`. Otherwise, `false`.
function M.is_string(value)
  return type(value) == 'string'
end

---@param value any value to check
---@return boolean # `true` if value is a list-like table. Otherwise `false`
function M.is_list(value)
  if type(value) ~= 'table' then
    return false
  end
  local count = 0
  for k, _ in pairs(value) do
    if type(k) ~= 'number' or k <= 0 or k % 1 ~= 0 then
      return false -- Not a positive integer key
    end
    count = count + 1
  end
  return count == #value
end

---@param value any value to check
---@return boolean # `true` if value is a list-like table with elements that pass `elem_checker`. Otherwise, `false`.
function M.is_list_type(value, elem_checker)
  if not M.is_list(value) then
    return false
  end
  for _, v in ipairs(value) do
    if not elem_checker(v) then
      return false
    end
  end
  return true
end

---@param value any value to check
---@return boolean # `true` if value is a list-like table with all elements being strings. Otherwise, `false`.
function M.is_string_list(value)
  return M.is_list_type(value, M.is_string)
end

---@param value any value to check
---@param checkers (fun(value:any):boolean)[] checkers to run on `value`
---@return boolean # `true` if at least one checker returns `true`. Otherwise, `false`.
function M.is_any(value, checkers)
  for _, checker in ipairs(checkers) do
    if checker(value) then
      return true
    end
  end
  return false
end

---@param value any value to check
---@param check_list any[] list of values to check if `value` is equal to
---@return boolean # `true` if at least one element in `check_list` is equal to `value`. Otherwise, `false`.
function M.is_any_value(value, check_list)
  for _, check in ipairs(check_list) do
    if value == check then
      return true
    end
  end
  return false
end

return M
