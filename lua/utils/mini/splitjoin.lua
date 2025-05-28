local M = {}
local gen = {}

local s = require('utils.str')

local set_text = function(start_row, start_col, end_row, end_col, replacement)
  local ok = pcall(vim.api.nvim_buf_set_text, 0, start_row, start_col, end_row, end_col, replacement)
  if not ok or #replacement == 0 then
    return
  end

  -- Fix cursor position if it was exactly on start position.
  -- See https://github.com/neovim/neovim/issues/22526.
  local cursor = vim.api.nvim_win_get_cursor(0)
  if (start_row + 1) == cursor[1] and start_col == cursor[2] then
    vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + replacement[1]:len() })
  end
end
local is_positions_inside_brackets = function(from_pos, to_pos, brackets)
  local text_lines = vim.api.nvim_buf_get_text(0, from_pos.line - 1, from_pos.col - 1, to_pos.line - 1, to_pos.col, {})
  local text = table.concat(text_lines, '\n')

  for _, b in ipairs(brackets) do
    if text:find('^' .. b .. '$') ~= nil then
      return true
    end
  end
  return false
end

function gen.add_trailing_comment(opts)
  opts = opts or {}
  local brackets = opts.brackets or { '%b()' }

  return function(split_positions)
    local sep = ''
    if vim.bo.commentstring ~= '' then
      sep = ' ' .. s.trimchars(string.gsub(vim.bo.commentstring, '%%s', ''), ' \t\n')
    end

    -- Add only in case there is at least one argument
    local n_pos = #split_positions
    if n_pos < 3 then
      return split_positions
    end

    -- Act only if brackets are matched
    local first, last = split_positions[1], split_positions[n_pos]
    local brackets_matched = is_positions_inside_brackets(first, last, brackets)
    if not brackets_matched then
      return split_positions
    end

    -- Add trailing separator
    for l = first.line, last.line - 2, 1 do
      local target_line = vim.fn.getline(l + 1)
      local col = target_line:len()
      set_text(l, col, l, col, { sep })
    end

    -- Don't update `split_positions`, as appending to line has no effect
    return split_positions
  end
end

------------------ Return ----------------
M.gen = gen
return M
