local mini_ai = require('mini.ai')
local spec_treesitter = mini_ai.gen_spec.treesitter

-- ============================================================
-- ========================== Custom ==========================
-- ============================================================

-- ~~~~~~~~~~~~ Function Specs ~~~~~~~~~~~~

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

-- ~~~~~~~~~~~ Treesitter Specs ~~~~~~~~~~~

local ts_F = spec_treesitter({ a = '@function.outer', i = '@function.inner' })
local ts_O = spec_treesitter({
  a = { '@class.outer', '@conditional.outer', '@loop.outer', '@block.outer' },
  i = { '@class.inner', '@conditional.inner', '@loop.inner', '@block.inner' },
})

-- ~~~~~~~~~~~ Textobject Table ~~~~~~~~~~~

-- Table with textobject id as fields, textobject specification as values.
-- Also use this to disable builtin textobjects. See |MiniAi.config|.
local custom_textobjects = {
  g = entire_buffer,
  l = current_line,

  -- Treesitter specs
  F = ts_F,
  O = ts_O,
}

-- ============================================================
-- ========================= Mappings =========================
-- ============================================================

-- Module mappings. Use `''` (empty string) to disable one.
local mappings = {
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
}

-- ============================================================
-- ========================== Options =========================
-- ============================================================

local opts = {
  custom_textobjects = custom_textobjects,
  mappings = mappings,

  -- Number of lines within which textobject is searched
  n_lines = 50,

  -- How to search for object (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
  search_method = 'cover_or_next',
}

-- ============================================================
-- =========================== Setup ==========================
-- ============================================================
mini_ai.setup(opts)
