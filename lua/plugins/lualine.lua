local function fileformat()
  local ff = vim.bo.fileformat
  local symbols
  if ff == 'unix' then
    symbols = [[\n]]
  elseif ff == 'dos' then
    symbols = [[\r\n]]
  else
    symbols = [[\r]]
  end
  return ff .. '(' .. symbols .. ')'
end

---@param s string
local function location_fmt(s)
  local selection = require('utils.vim.selection').get()
  if selection == nil then
    return s
  end
  local selection_str = table.concat(selection, '\n')
  return string.format('%s (%d)', s, #selection_str)
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '│', right = '│' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = false,
      globalstatus = true,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', fileformat, 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { { 'location', fmt = location_fmt } },
    },
    extensions = {
      'lazy',
      'man',
      'mason',
      'neo-tree',
      'nvim-dap-ui',
      'quickfix',
      'trouble',
      'toggleterm',
    },
  },
}
