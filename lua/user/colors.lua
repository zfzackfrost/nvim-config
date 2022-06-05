vim.g.material_style = 'ocean'

require('material').setup({
  contrast = {
    sidebars = true,
    floating_windows = true,
    line_numbers = true,
    cursor_line = true,
  },
  italics = {
    comments = true,
  },
  contrast_filetypes = {
    'terminal',
    'fugitive',
    'packer',
    'qf',
  },
  disable = {
    colored_cursor = false,
  },
  custom_colors = {
    darkpurple = '#984DC8',
  },
})
vim.cmd([[colorscheme material]])
