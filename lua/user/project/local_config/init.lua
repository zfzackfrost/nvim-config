local M = { config = {} }
local F = require('user.utils.functional')
local Buffer = Utils.Buffer

local lazy = require('user.utils.lazy')

local core = lazy.require_on_exported_call('user.utils.core')
local is_callable = core.is_callable

local guess_root = Project.root.guess
local load_yaml = lazy.require_on_exported_call('lyaml').load
local fs = lazy.require_on_index('user.utils.fs')

local interp_config = lazy.require_on_exported_call('user.project.local_config.interpolate').interp_config
local make_interp_env = lazy.require_on_exported_call('user.project.local_config.interpolate', { 'env' }).make_env

local CFG_DIR = '.nvim-project'

function M.get(ty)
  return M.config[ty]
end
function M.set(ty, cfg)
  M.config[ty] = cfg
end

function M.get_loaded_event_name(ty)
  return ('UserProjectConfigLoaded_%s'):format(ty)
end

local function load_config_base(buf, ty, callback)
  buf = buf or 0
  local buf_name = vim.api.nvim_buf_get_name(buf)
  local root = guess_root(buf_name)
  local config_file = fs.Path.first_existing_file({
    fs.Path.join(root, CFG_DIR, ty .. '.yml'),
    fs.Path.join(root, CFG_DIR, ty .. '.yaml'),
  })
  if config_file == nil then
    M.set(ty, nil)
    if is_callable(callback) then
      callback(buf)
    end
    return
  end

  local config_env
  local is_env = true
  if ty ~= 'env' then
    config_env = M.get('env')
    is_env = false
  end
  config_env = make_interp_env(root, is_env, config_env)

  fs.read_file(
    config_file,
    vim.schedule_wrap(function(config_yml)
      local config_tbl = interp_config(load_yaml(config_yml), config_env)
      M.set(ty, config_tbl)
      vim.api.nvim_exec_autocmds('User', {
        pattern = M.get_loaded_event_name(ty),
      })
      if is_callable(callback) then
        callback(buf)
      end
    end)
  )
end

function M.load_env_config(buf)
  load_config_base(buf, 'env', F.call_all(M.load_lsp_config, M.load_tasks_config))
end

function M.load_lsp_config(buf)
  load_config_base(buf, 'lsp')
end

function M.load_tasks_config(buf)
  load_config_base(buf, 'tasks')
end

M.setup = function()
  local group = vim.api.nvim_create_augroup('user_project_local_config', {})

  local exclude = {
    filetype = {
      '^help$',
      '^qf$',
      '^NvimTree$',
      '^Trouble$',
      '^starter$',
      '^Telescope%w*$',
    },
    buftype = {
      '^help$',
      '^quickfix$',
      '^nofile$',
      '^terminal$',
    }
  }
  vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter', 'BufRead' }, {
    group = group,
    callback = function()
      local buf = Buffer:new({ handle = 0 })
      if not buf:match({}, exclude) then
        return
      end
      M.load_env_config(buf.handle)
    end,
  })
end

return M
