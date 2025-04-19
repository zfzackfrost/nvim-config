return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require('config.snacks')
    end,
  },
}
