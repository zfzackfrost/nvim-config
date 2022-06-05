return function()
  require('nvim-tree').setup({
    view = {
      side = 'right',
    },
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
    git = {
      ignore = false,
    }
  })
end
