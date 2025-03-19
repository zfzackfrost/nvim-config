local function entire_buffer()
  local from = { line = 1, col = 1 }
  local to = {
    line = vim.fn.line('$'),
    col = math.max(vim.fn.getline('$'):len(), 1),
  }
  return { from = from, to = to }
end
local function current_line(ai)
  local line = vim.fn.line('.')
  local line_s = vim.fn.getline('.')
  local from_col = 1
  local to_col = math.max(line_s:len(), 1)

  if ai == 'i' then
    -- Find first non-whitespace
    for i = 1, line_s:len(), 1 do
      if line_s:sub(i, i):find('%s') ~= nil then
        from_col = from_col + 1
      else
        break
      end
    end

    -- Find last non-whitespace
    for i = line_s:len(), 1, -1 do
      if line_s:sub(i, i):find('%s') ~= nil then
        to_col = to_col - 1
      else
        break
      end
    end
  end
  local from = {
    line = line,
    col = from_col,
  }
  local to = {
    line = line,
    col = to_col,
  }
  return { from = from, to = to }
end

return {
  {
    'echasnovski/mini.ai',
    version = false,
    opts = {
      -- Table with textobject id as fields, textobject specification as values.
      -- Also use this to disable builtin textobjects. See |MiniAi.config|.
      custom_textobjects = {
        g = entire_buffer,
        l = current_line,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Main textobject prefixes
        around = 'a',
        inside = 'i',

        -- Next/last variants
        around_next = 'aN',
        inside_next = 'iN',
        around_last = 'aL',
        inside_last = 'iL',

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = 'g[',
        goto_right = 'g]',
      },

      -- Number of lines within which textobject is searched
      n_lines = 50,

      -- How to search for object (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
      search_method = 'cover_or_next',
    },
  },
}
