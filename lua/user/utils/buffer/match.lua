local api = vim.api

local function contains_matching_pattern(tbl, s)
  for _, pat in ipairs(tbl) do
    if s:find(pat) ~= nil then
      return true
    end
  end
  return false
end

return function(buf, include, exclude)
  if not api.nvim_buf_is_valid(buf) then
    return nil
  end

  include = include or {}
  exclude = exclude or {}

  local include_names = include.name or {}
  local include_filetypes = include.filetype or {}
  local include_buftypes = include.buftype or {}

  local exclude_names = exclude.name or {}
  local exclude_filetypes = exclude.filetype or {}
  local exclude_buftypes = exclude.buftype or {}

  local name = api.nvim_buf_get_name(buf)
  local filetype = api.nvim_buf_get_option(buf, 'filetype')
  local buftype = api.nvim_buf_get_option(buf, 'buftype')

  if contains_matching_pattern(exclude_names, name) then
    return false
  end
  if contains_matching_pattern(exclude_filetypes, filetype) then
    return false
  end
  if contains_matching_pattern(exclude_buftypes, buftype) then
    return false
  end

  if #include_names >= 1 and not contains_matching_pattern(include_names, name) then
    return false
  end
  if #include_filetypes >= 1 and not contains_matching_pattern(include_filetypes, filetype) then
    return false
  end
  if #include_buftypes >= 1 and not contains_matching_pattern(include_buftypes, buftype) then
    return false
  end

  return true
end
