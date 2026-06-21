return {
  {
    'willothy/flatten.nvim',
    lazy = false,
    enabled = false,
    priority = 6001,
    config = function()
      require('config.flatten')
    end,
  },
}
