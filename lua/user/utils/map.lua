local M = {}
local F = require('user.utils.functional')

local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local valid_modes = { '', 'n', 'v', 's', 'x', 'o', '!', 'i', 'l', 'c', 't' }
local function is_valid_mode(ch)
  return F.any(F.partial(F.op.eq, ch), valid_modes)
end

local iter_modes = function(modes)
  return F.map(function(x)
    if x == ' ' then
      return ''
    else
      return x
    end
  end, modes)
end

M.map = function(modes, lhs, rhs, opts)
  local base_opts = { noremap = true, silent = true }
  opts = vim.tbl_extend('force', base_opts, opts or {})
  local buffer = opts.buffer
  opts.buffer = nil
  if type(rhs) == 'function' then
    opts.callback = rhs
    rhs = ''
  end
  if type(lhs) ~= 'table' then
    lhs = { lhs }
  end

  F.each(function(mode)
    if not is_valid_mode(mode) then
      error(('Invalid mode character: %s'):format(vim.inspect(mode)), 4)
    end
    for _, tmp_lhs in ipairs(lhs) do
      if buffer ~= nil then
        vim.api.nvim_buf_set_keymap(buffer, mode, tmp_lhs, rhs, opts)
      else
        vim.api.nvim_set_keymap(mode, tmp_lhs, rhs, opts)
      end
    end
  end, iter_modes(modes))
end

M.group_name = function(modes, lhs, desc, opts)
  local wk = require('which-key')
  desc = desc or 'which_key_ignore'
  opts = opts or {}

  for i = 1, #modes do
    local mode = modes:sub(i, i)
    wk.register({
      [lhs] = { name = desc },
    }, { mode = mode, buffer = opts.buffer })
  end
end

local function map_name_impl(modes, lhs, desc, opts)
  opts = opts or {}
  if opts.ft ~= nil then
    local ft_label = opts.ft
    if type(ft_label) == 'table' then
      ft_label = table.concat(ft_label, '_')
    end
    local group = create_augroup(('user_ft_map_name_%s_%s'):format(modes, ft_label), { clear = false })
    create_autocmd('FileType', {
      group = group,
      pattern = opts.ft,
      callback = function(t)
        local tmp_opts = vim.deepcopy(opts)
        tmp_opts.buffer = t.buf
        tmp_opts.ft = nil
        map_name_impl(modes, lhs, desc, tmp_opts)
      end,
    })
    return
  end

  local wk = require('which-key')
  if type(lhs) ~= 'table' then
    lhs = { lhs }
  end
  desc = desc or 'which_key_ignore'

  for i = 1, #modes do
    local mode = modes:sub(i, i)
    for _, tmp_lhs in ipairs(lhs) do
      wk.register({
        [tmp_lhs] = { desc },
      }, { mode = mode, buffer = opts.buffer })
    end
  end
end
M.map_name = map_name_impl

M.tc = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
