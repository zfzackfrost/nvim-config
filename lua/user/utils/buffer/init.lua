local placeholder = require('user.utils.placeholder')

local default_create_opts = {
  listed = false,
  scratch = true,
}
local Buffer = {
  handle = placeholder(),
  create = placeholder(),
}

local function invalidate(self)
  if not self:is_valid() then
    self.handle = placeholder()
    return true
  end
  return false
end

local function is_buffer(self)
  if type(self) ~= 'table' then
    return false
  end
  return getmetatable(self) == Buffer
end

local function list_bufs()
  local bufs = vim.api.nvim_list_bufs()
  return vim.tbl_map(function(handle)
    return Buffer:new({ handle = handle })
  end, bufs)
end

local function create(self, opts)
  local listed = opts.listed or default_create_opts.listed
  local scratch = opts.scratch or default_create_opts.scratch
  local handle = vim.api.nvim_create_buf(listed, scratch)
  self.handle = handle
end

function Buffer:new(opts)
  opts = opts or {}


  -- Process options
  if not placeholder.is_placeholder(opts.create) and opts.create ~= nil then
    local create_opts = vim.deepcopy(opts.create)
    opts.create = nil
    create(opts, create_opts)
  elseif opts.handle == 0 then
    opts.handle = vim.api.nvim_get_current_buf()
  end

  setmetatable(opts, self)
  self.__index = function(t, key)
    local v_tbl
    if key ==  'vars' then
      v_tbl = vim.b
    elseif key == 'opts' then
      v_tbl = vim.bo
    end
    if v_tbl ~= nil then
      if t.handle ~= nil and not Buffer.is_valid(t) then
        error(("Attempting to access `%s` for invalid buffer"):format(key), 2)
      end
      return v_tbl[t.handle]
    else
      return self[key]
    end
  end
  self.__tostring = function(t)
    return ('Buffer{handle=%s}'):format(tostring(t.handle))
  end
  self.__eq = function(a, b)
    return a.handle == b.handle
  end

  return opts
end


function Buffer:is_valid()
  if placeholder.is_placeholder(self.handle) then
    return false
  end
  if not vim.api.nvim_buf_is_valid(self.handle) then
    return false
  end
  return true
end

function Buffer:is_loaded()
  if placeholder.is_placeholder(self.handle) then
    return false
  end
  if not vim.api.nvim_buf_is_loaded(self.handle) then
    return false
  end
  return true
end

function Buffer:is_modified()
  if invalidate(self) then
    error('Failed to call `is_modified` on Buffer: Invalid handle!', 2)
  end
  return vim.bo[self.handle].modified
end

function Buffer:name(new_name)
  if invalidate(self) then
    error('Failed to call `name` on Buffer: Invalid handle!', 2)
  end

  local old_name = vim.api.nvim_buf_get_name(self.handle)
  if type(new_name) == 'string' then
    vim.api.nvim_buf_set_name(self.handle, new_name)
  end
  return old_name
end

function Buffer:wipe(force, unload)
  if invalidate(self) then
    return error('Failed to call `wipe` on Buffer: Invalid handle!', 2)
  end
  vim.api.nvim_buf_delete(self.handle, { force = force, unload = unload })
end

function Buffer:delete()
  if invalidate(self) then
    return error('Failed to call `delete` on Buffer: Invalid handle!', 2)
  end
  vim.cmd(string.format('bdelete %d', self.handle))
end

function Buffer:match(include, exclude)
  if invalidate(self) then
    return error('Failed to call `match` on Buffer: Invalid handle!', 2)
  end
  return require('user.utils.buffer.match')(self.handle, include, exclude)
end

return setmetatable({
  list_bufs = list_bufs,
  is_buffer = is_buffer,
}, {
  __index = Buffer,
  __call = function(_, opts)
    return Buffer:new(opts)
  end,
})
