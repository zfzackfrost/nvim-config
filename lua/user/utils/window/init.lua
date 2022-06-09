local placeholder = require('user.utils.placeholder')
local cfg_ty = require('user.utils.window.config_types')
local Buffer = require('user.utils.buffer')

local eval_size = function(x, vertical)
  x = math.abs(x)
  if x > 1 then
    return x
  else
    local base = vertical and vim.o.columns or vim.o.lines
    return math.floor(x * base)
  end
end

local Window = {
  handle = placeholder(),
  __tostring = function(self)
    return ('Window{handle=%s}'):format(tostring(self.handle))
  end,
}

local function open(self, win_opts)
  -- If already open, do nothing
  if self:is_valid() then
    return
  end

  local base_buffer_opts = {
    mode = cfg_ty.OpenBufferMode.BufnrOption,
    bufnr = 0,
    listed = false,
    scratch = true,
  }
  local base_win_opts = {
    buffer = base_buffer_opts,
    edge = cfg_ty.DockEdge.Bottom,
    win_type = cfg_ty.WindowType.Split,
    size = 0.3,
  }
  win_opts = vim.tbl_deep_extend('force', base_win_opts, win_opts or {})

  local edge = win_opts.edge
  local vertical = edge == cfg_ty.DockEdge.Right or edge == cfg_ty.DockEdge.Left
  win_opts.size = eval_size(win_opts.size, vertical)

  local buffer_mode = win_opts.buffer.mode
  if buffer_mode == cfg_ty.OpenBufferMode.BufnrOption then
    win_opts.buffer = win_opts.buffer.bufnr
    if win_opts.buffer == 0 then
      win_opts.buffer = vim.api.nvim_get_current_buf()
    end
  elseif
    buffer_mode == cfg_ty.OpenBufferMode.CreateEmpty
    or buffer_mode == cfg_ty.OpenBufferMode.CreateEmptyDestroyOnClose
  then
    win_opts.buffer = vim.api.nvim_create_buf(win_opts.buffer.listed, win_opts.buffer.scratch)
  else
    error('Invalid value for win_opts.buffer.mode: ' .. vim.inspect(win_opts.buffer.mode))
  end

  local win_type = win_opts.win_type
  local status_ok, openers = pcall(require, ('user.utils.window.openers.%s'):format(win_type))
  if not status_ok then
    error('Invalid value for win_opts.win_type: ' .. vim.inspect(win_opts.win_type))
  end

  local opener = openers[edge]
  if type(opener) ~= 'function' then
    error('Invalid value for win_opts.edge: ' .. vim.inspect(win_opts.edge))
  end

  local new_handle
  status_ok, new_handle = pcall(opener, win_opts)
  if not status_ok then
    error('Failed to open window!', 2)
    return
  end

  self.handle = new_handle

  if buffer_mode == cfg_ty.OpenBufferMode.CreateEmptyDestroyOnClose then
    local buffer = self:buffer()
    buffer.opts.bufhidden = 'wipe'
  end
end

local function invalidate(self)
  if not self:is_valid() then
    self.handle = placeholder()
    return true
  end
  return false
end

local function is_window(self)
  if type(self) ~= 'table' then
    return false
  end
  return getmetatable(self) == Window
end

function Window:new(opts)
  opts = opts or {}

  -- Process options
  local has_win_opts = opts.create ~= nil
  local win_opts = vim.deepcopy(opts.create or {})
  opts.create = nil

  if opts.handle == 0 then
    opts.handle = vim.api.nvim_get_current_win()
  end

  -- Setup metatable
  setmetatable(opts, self)
  self.__index = function(t, key)
    local v_tbl
    if key == 'vars' then
      v_tbl = vim.w
    elseif key == 'opts' then
      v_tbl = vim.wo
    end
    if v_tbl ~= nil then
      if t.handle ~= nil and not Window.is_valid(t) then
        error(('Attempting to access `%s` for invalid window'):format(key), 2)
      end
      return v_tbl[t.handle]
    else
      return self[key]
    end
  end

  if has_win_opts then
    open(opts, win_opts)
  end
  return opts
end

function Window:is_valid()
  if placeholder.is_placeholder(self.handle) then
    return false
  end
  if not vim.api.nvim_win_is_valid(self.handle) then
    return false
  end
  return true
end

function Window:buffer()
  if invalidate(self) then
    error('Failed to execute `buffer` on Window: Invalid handle!', 2)
  end
  return Buffer:new({ handle = vim.api.nvim_win_get_buf(self.handle) })
end

function Window:close(force)
  if invalidate(self) then
    error('Failed to execute `close` on Window: Invalid handle!', 2)
  end

  -- Close window, ignore errors
  pcall(vim.api.nvim_win_close, self.handle, force or false)
end

function Window:focus()
  if invalidate(self) then
    error('Failed to execute `focus` on Window: Invalid handle!', 2)
  end
  vim.api.nvim_set_current_win(self.handle)
end

function Window:call(func)
  if invalidate(self) then
    error('Failed to execute `call` on Window: Invalid handle!', 2)
  end
  return vim.api.nvim_win_call(self.handle, func)
end

return setmetatable({ is_window, config = cfg_ty }, {
  __index = Window,
  __call = function(_, opts)
    return Window:new(opts)
  end,
})
