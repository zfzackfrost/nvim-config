local M = { env = require('user.project.local_config.interpolate.env') }

local fs = require('user.utils.fs')
local F = require('user.utils.functional')

local function get_base(key, env)
  local x = env[key]
  return F.if_nil(x, '', x)
end

local function noop_transformer(s)
  return s
end
local function get_transformer(key)
  local status_ok, x = pcall(require, string.format('user.project.local_config.interpolate.transformer.%s', key))
  if status_ok then
    return x
  else
    return noop_transformer
  end
end
local function replacer(env)
  return function(s)
    local parts = vim.split(s, '|', { plain = true, trimempty = true })
    local base = get_base(parts[1], env)
    if #parts == 1 then
      return base
    end
    local xform_keys = { unpack(parts, 2, #parts) }
    local result = base
    for _, x in ipairs(xform_keys) do
      result = tostring(get_transformer(x)(result))
    end
    return result
  end
end
local function interp_string(s, env)
  return string.gsub(s, [[{([%w%s:|_]+)}]], replacer(env))
end

function M.interp_config(t, env)
  for k, v in pairs(t) do
    if type(v) == 'string' then
      t[k] = interp_string(v, env)
    elseif type(v) == 'table' then
      t[k] = M.interp_config(v, env)
    end
  end
  return t
end

return M
