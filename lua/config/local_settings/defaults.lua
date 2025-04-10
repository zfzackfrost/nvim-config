---@module 'config.local_settings.types'
---@type LocalSettings
local defaults = {}

local enable_hints_fts = {
  'rust',
  'typescript',
  'typescriptreact',
  'javascript',
  'javascriptreact',
  'svelte',
}
local format_on_save_fts = {
  'c',
  'cpp',
  'css',
  'gdscript',
  'go',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'lua',
  'markdown',
  'python',
  'rust',
  'scss',
  'svelte',
  'typescript',
  'typescriptreact',
  'xml',
  'zig',
}
for _, ft in ipairs(enable_hints_fts) do
  if defaults[ft] == nil then
    defaults[ft] = {}
  end
  defaults[ft].lsp_enable_hints = true
end
for _, ft in ipairs(format_on_save_fts) do
  if defaults[ft] == nil then
    defaults[ft] = {}
  end
  defaults[ft].format_on_save = true
end

return defaults
