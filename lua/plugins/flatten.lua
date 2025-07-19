return {
  {
    'willothy/flatten.nvim',
    lazy = false,
    priority = 6001,
    config = function()
      require('config.flatten')
    end,
  },
}
