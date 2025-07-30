local M = {}

-- Function to convert UPPER_SNAKE_CASE to PascalCase
function M.snake_to_pascal(snake_str)
  if not snake_str or snake_str == '' then
    return ''
  end

  -- Convert to lowercase first
  local result = string.lower(snake_str)

  -- Replace underscores followed by letters with uppercase letters
  result = string.gsub(result, '_(%w)', function(letter)
    return string.upper(letter)
  end)

  -- Capitalize the first letter (this is the key difference from camelCase)
  result = string.upper(string.sub(result, 1, 1)) .. string.sub(result, 2)

  return result
end

function M.snake_to_camel(snake_str)
  if not snake_str or snake_str == '' then
    return ''
  end

  -- Convert to lowercase and replace each underscore followed by a letter
  -- with just the uppercase version of that letter
  local result = string.lower(snake_str)
  result = string.gsub(result, '_(%w)', function(letter)
    return string.upper(letter)
  end)

  return result
end

---Repeat a string
---@param s string the string
---@param n integer number of times to repeat
---@return string #`s` concatenated with itself `n` times
function M.rep(s, n)
  local rv = ''
  for _ = 1, n, 1 do
    rv = rv .. s
  end
  return rv
end

---Remove a prefix from a string
---@param s string the string
---@param v string the prefix to remove
---@return string # `s` with `p` removed from the start
function M.strip_prefix(s, v)
  return (M.starts_with(s, v)) and s:sub(#v + 1) or s
end

---Remove a suffix from a string
---@param s string the string
---@param v string the suffix to remove
---@return string # `s` with `v` removed from the end
function M.strip_suffix(s, v)
  return M.ends_with(s, v) and s:sub(1, -#v - 1) or s
end

---Check if a string begins with a prefix
---@param s string the string
---@param v string the prefix to remove
---@return boolean # true if `s` begins with `v`. Otherwise false.
function M.starts_with(s, v)
  return s:sub(1, #v) == v
end

---Check if a string ends with a suffix
---@param s string the string
---@param v string the suffix to remove
---@return boolean # true if `s` ends with `v`. Otherwise false.
function M.ends_with(s, v)
  return s:sub(-string.len(v)) == v
end

---Trim characters from the start of a string
---@param s string the string
---@param chars string a string with the characters to trim
---@return string # `s` with all characters in `chars` removed from the start
function M.trimchars_start(s, chars)
  local chars_list = M.split_chars(chars)
  for i = 1, #s, 1 do
    if not vim.list_contains(chars_list, s:sub(i, i)) then
      break
    end
    s = s:sub(2)
  end
  return s
end

---Trim characters from the end of a string
---@param s string the string
---@param chars string a string with the characters to trim
---@return string # `s` with all characters in `chars` removed from the end
function M.trimchars_end(s, chars)
  local chars_list = M.split_chars(chars)
  for i = #s, 1, -1 do
    if not vim.list_contains(chars_list, s:sub(i, i)) then
      break
    end
    s = s:sub(1, -2)
  end
  return s
end

---Trim characters from the start and end of a string
---@param s string the string
---@param chars string a string with the characters to trim
---@return string # `s` with all characters in `chars` removed from the start and end
function M.trimchars(s, chars)
  s = M.trimchars_start(s, chars)
  s = M.trimchars_end(s, chars)
  return s
end

---Separate a string into a list of characters
---@param s string the string
---@return string[] # A list of the characters in `s`
function M.split_chars(s)
  local t = {}
  for i = 1, #s do
    table.insert(t, s:sub(i, i))
  end
  return t
end
return M
