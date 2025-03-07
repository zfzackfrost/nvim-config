return {
  'echasnovski/mini.notify',
  version = false,
  priority = 1000,
  opts = {
    window = {
      winblend = 0,
    },
  },
  config = function(_, opts)
    require('mini.notify').setup(opts)
    vim.notify = MiniNotify.make_notify()
  end,
}
