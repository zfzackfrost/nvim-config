local M = {}

---If function
---@param choose_a boolean Return value `a`?
---@generic A # Type of `a`
---@param a A first value
---@generic B # Type of `b`
---@param b B second value
---@return A|B # `a` if `choose_a` is `true`. Otherwise `b`.
function M.iff(choose_a, a, b)
  if choose_a then
    return a
  end
  return b
end

---Wrap a call to `vim.defer_fn` in a new function.
---The returned function accepts vaargs, which it forwards to the callback.
---@param fn function # Callback to execute after a delay
---@param timeout integer # Number of milliseconds to wait
---@return fun(...) # new function that calls `vim.defer_fn` with `fn` and `timeout`.
function M.defer_wrap(fn, timeout)
  return function(...)
    local args = utils.table.pack(...)
    vim.defer_fn(function()
      fn(utils.table.unpack(args))
    end, timeout)
  end
end

return M
