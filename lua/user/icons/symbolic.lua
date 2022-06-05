local M = {}

local F = Utils.functional
local T = Utils.tbl

local set_hl = vim.api.nvim_set_hl
local snake_to_pascal = Utils.strcase.snake_to_pascal

M._ICONS_NAME = 'Symbolic'

M.icons = {
  {
    key = 'project',
    label = 'Project',
    text = '',
    color_key = 'fg',
  },
  {
    key = 'config',
    label = 'Configuration',
    text = '',
    color_key = 'blue',
  },
  {
    key = 'compiler',
    label = 'Compiler',
    text = '',
    color_key = 'blue',
  },
  {
    key = 'time',
    label = 'Time',
    text = '',
    color_key = 'blue',
  },
  {
    key = 'game',
    label = 'Games and Entertainment',
    text = '',
    color_key = 'blue',
  },
  {
    key = 'ai',
    label = 'AI and Automation',
    text = 'ﮧ',
    color_key = 'blue',
  },
  {
    key = 'graphics',
    label = 'Graphics, GUI and Rendering',
    text = '',
    color_key = 'blue',
  },
  {
    key = 'data_exchange',
    label = 'Data Exchange (JSON, YAML, XML, etc.)',
    text = 'ﬥ',
    color_key = 'yellow',
  },
  {
    key = 'data_table',
    label = 'Table Data (CSV, TSV, etc.)',
    text = '',
    color_key = 'yellow',
  },
  {
    key = 'app_web',
    label = 'Web App',
    text = '',
    color_key = 'darkorange',
  },
  {
    key = 'app_terminal',
    label = 'Terminal App',
    text = '',
    color_key = 'darkorange',
  },
  {
    key = 'app_script',
    label = 'Script App',
    text = '亮',
    color_key = 'darkorange',
  },
  {
    key = 'app_native',
    label = 'Native App',
    text = 'ﱦ',
    color_key = 'darkorange',
  },
}

M.icon_hl_group = function(icon_key)
  return 'UserSymbolicIcon' .. snake_to_pascal(icon_key)
end

M.icon_by_key = function(icon_key)
  return F.find_head(F.xform_args(F.partial(F.op.eq, icon_key), T.get, { 'key' }), M.icons)
end

local function set_icon_highlight(colors, v)
  local group_name = M.icon_hl_group(v.key)
  set_hl(0, group_name, {
    fg = colors[v.color_key],
  })
end

local function modify_colorscheme()
  local colors = require('user.data.theme_colors')()
  F.each(F.partial(set_icon_highlight, colors), M.icons)
end

function M.setup()
  local group = vim.api.nvim_create_augroup('user_symbolic_icons', {})
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group,
    callback = modify_colorscheme,
  })
end

return M
