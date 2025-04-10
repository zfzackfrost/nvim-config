return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      indent = { enabled = true },
      dashboard = { enabled = true },
      notifier = { enabled = true },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      vim.ui.select = Snacks.picker.select
    end,
  },
}
