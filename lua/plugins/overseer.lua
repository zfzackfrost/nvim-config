return {
  {
    'stevearc/overseer.nvim',
    event = 'VeryLazy',
    opts = {
      strategy = 'toggleterm',
      form = {
        border = 'single',
      },
      confirm = {
        border = 'single',
      },
      task_win = {
        border = 'single',
      },
      help_win = {
        border = 'single',
      },
    },
  },
}
