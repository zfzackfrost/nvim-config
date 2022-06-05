local function make_extension(filetypes, label)
  local label_comp = function()
    return label
  end
  return {
    sections = {
      lualine_a = { 'mode' },
      lualine_c = { label_comp },
    },
    filetypes = filetypes,
  }
end

require('lualine').setup({
  options = {
    theme = 'auto',
    component_separators = '│',
    globalstatus = true,
  },
  extensions = {
    make_extension({ 'TelescopePrompt' }, 'Telescope'),
    make_extension({ 'starter' }, 'Starter'),
    make_extension({ 'packer' }, 'Packer'),
    'fugitive',
    'nvim-tree',
    'quickfix',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filesize', require('user.lualine.filename') },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = { { 'buffers', mode = 2 } },
    lualine_z = { 'tabs' },
  },
})
