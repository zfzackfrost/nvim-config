---@module 'config.local_settings.types'

local v = require('utils.validate')

---@param ft_config FiletypeSettings
local function handle_lsp_enable_hints(ft_config)
  if not v.is_any(ft_config.lsp_enable_hints, { v.is_bool, v.is_nil }) then
    vim.b.lsp_enable_hints = nil
    vim.notify('Invalid value for lsp_enable_hints!', vim.log.levels.ERROR)
  else
    vim.b.lsp_enable_hints = ft_config.lsp_enable_hints
  end
end

---@param ft_config FiletypeSettings
local function handle_autostart_server(ft_config)
  if not v.is_any(ft_config.autostart_server, { v.is_bool, v.is_nil }) then
    vim.b.autostart_server = nil
    vim.notify('Invalid value for autostart_server!', vim.log.levels.ERROR)
  else
    vim.b.autostart_server = ft_config.autostart_server
  end
end

---@param ft_config FiletypeSettings
local function handle_format_on_save(ft_config)
  if not v.is_any(ft_config.format_on_save, { v.is_bool, v.is_nil }) then
    vim.b.format_on_save = nil
    vim.notify('Invalid value for format_on_save!', vim.log.levels.ERROR)
  else
    vim.b.format_on_save = ft_config.format_on_save
  end
end

---@param ft_config FiletypeSettings
local function handle_formatters(ft_config)
  if not v.is_any(ft_config.formatters, { v.is_nil, v.is_string_list, v.is_string }) then
    vim.b.formatters = nil
    vim.notify('Invalid value for formatters!', vim.log.levels.ERROR)
  elseif ft_config ~= nil then
    if type(ft_config.formatters) == 'string' then
      vim.b.formatters = { ft_config.formatters }
    else
      vim.b.formatters = ft_config.formatters
    end
  end
end

---@param ft_config FiletypeSettings
local function handle_lsp_format(ft_config)
  local function is_valid_lsp_format(value)
    return v.is_any_value(value, { 'never', 'fallback', 'first', 'last', 'prefer' })
  end
  if not v.is_any(ft_config.lsp_format, { v.is_nil, is_valid_lsp_format }) then
    vim.b.lsp_format = nil
    vim.notify('Invalid value for lsp_format!', vim.log.levels.ERROR)
  else
    vim.b.lsp_format = ft_config.lsp_format
  end
end

---@param settings LocalSettings
local function handle_local_settings(settings)
  ---@type FiletypeSettings
  local ft_config = {}
  for ft, config in pairs(settings) do
    if vim.bo.filetype == ft then
      ft_config = config
      break
    end
  end
  handle_autostart_server(ft_config)
  handle_format_on_save(ft_config)
  handle_formatters(ft_config)
  handle_lsp_format(ft_config)
  handle_lsp_enable_hints(ft_config)
end

local function load_local_settings()
  local settings = require('config.local_settings.file').read_settings()
  handle_local_settings(settings)
end
vim.api.nvim_create_user_command('LoadLocalSettings', load_local_settings, {})
