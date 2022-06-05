-- Copyright (c) 2020-2021 shadmansaleh
-- MIT license, see LICENSE for more details.
--
-- Modified by Zachary Frost for personal use
local M = require('lualine.component'):extend()

local modules = require('lualine_require').lazy_require({
  utils = 'lualine.utils.utils',
})

local default_options = {
  symbols = { modified = '[+]', readonly = '', unnamed = '[No Name]', scratch = '[Scratch]' },
  file_status = true,
  path = 3,
  shorting_target = 120,
}

---counts how many times pattern occur in base ( used for counting path-sep )
---@param base string
---@param pattern string
---@return number
local function count(base, pattern)
  return select(2, string.gsub(base, pattern, ''))
end

---shortens path by turning apple/orange -> a/orange
---@param path string
---@param sep string path separator
---@return string
local function shorten_path(path, sep)
  -- ('([^/])[^/]+%/', '%1/', 1)
  return path:gsub(string.format('([^%s])[^%s]+%%%s', sep, sep, sep), '%1' .. sep, 1)
end

M.init = function(self, options)
  M.super.init(self, options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, default_options)
end

M.update_status = function(self)
  local data
  local has_buffer_label = false
  if vim.b.user_buffer_label ~= nil then
    has_buffer_label = true
    data = vim.b.user_buffer_label
  elseif self.options.path == 1 then
    -- relative path
    data = vim.fn.expand('%:~:.')
  elseif self.options.path == 2 then
    -- absolute path
    data = vim.fn.expand('%:p')
  elseif self.options.path == 3 then
    -- absolute path, with tilde
    data = vim.fn.expand('%:p:~')
  else
    -- just filename
    data = vim.fn.expand('%:t')
  end

  data = modules.utils.stl_escape(data)

  if not has_buffer_label then
    if vim.bo.buftype == 'nofile' and vim.bo.bufhidden == 'hide' and not vim.bo.swapfile then
      data = self.options.symbols.scratch
    elseif data == '' then
      data = self.options.symbols.unnamed
    end
  end

  if not has_buffer_label and self.options.shorting_target ~= 0 then
    local windwidth = self.options.globalstatus and vim.go.columns or vim.fn.winwidth(0)
    local estimated_space_available = windwidth - self.options.shorting_target

    local path_separator = package.config:sub(1, 1)
    for _ = 0, count(data, path_separator) do
      if windwidth <= 84 or #data > estimated_space_available then
        data = shorten_path(data, path_separator)
      end
    end
  end

  if self.options.file_status then
    if vim.bo.modified then
      data = data .. self.options.symbols.modified
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
      data = data .. self.options.symbols.readonly
    end
  end
  return data
end

return M
