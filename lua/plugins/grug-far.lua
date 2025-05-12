return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar' },
    ---@type grug.far.OptionsOverride
    opts = {
      keymaps = {
        close = {
          n = '<Esc>',
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
