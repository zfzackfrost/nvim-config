local M = {}

local default_settings = {}
local enable_hints_fts = {
  'rust',
  'typescript',
  'typescriptreact',
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
  if default_settings[ft] == nil then
    default_settings[ft] = {}
  end
  default_settings[ft].lsp_enable_hints = true
end
for _, ft in ipairs(format_on_save_fts) do
  if default_settings[ft] == nil then
    default_settings[ft] = {}
  end
  default_settings[ft].format_on_save = true
end

local function get_file_path()
  local path = vim.fn.expand('%:p:h')
  if not vim.uv.fs_stat(path) then
    path = vim.fn.getcwd()
  end
  local files = vim.fs.find({ '.nvim.json', 'nvim.json' }, {
    type = 'file',
    path = path,
    upward = true,
  })
  if #files > 0 then
    return files[1]
  end
end

function M.read_settings()
  local p = get_file_path()
  local defaults = default_settings
  if p == nil then
    return defaults
  end
  local f = io.open(p, 'rb')
  if f == nil then
    return defaults
  end
  local j = f:read('*a')
  f:close()
  local ok, settings = pcall(vim.json.decode, j)
  if ok then
    return vim.tbl_deep_extend('force', defaults, settings)
  end
  return defaults
end

return M
