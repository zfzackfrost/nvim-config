return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar' },
    opts = {
      keymaps = {
        close = {
          n = 'q',
          i = '<C-c>',
        },
        nextInput = {
          n = '<Tab>',
          i = '<Tab>',
        },
        prevInput = {
          n = '<S-Tab>',
          i = '<S-Tab>',
        },
      },
    },
  },
}
