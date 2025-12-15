return {
  {
    'folke/edgy.nvim',
    event = 'VeryLazy',
    ---@module 'edgy'
    ---@type Edgy.Config
    opts = {
      animate = {
        enabled = false,
      },
      wo = {
        winbar = true,
        winhighlight = 'WinBar:EdgyWinBar,Normal:EdgyNormal',
      },
      left = {
        {
          ft = 'neo-tree',
          wo = {
            winbar = 'File Tree  ',
          },
        },
      },
      right = {
        {
          ft = 'grug-far',
          wo = {
            winbar = 'Grug Far  ',
          },
          size = { width = 45 },
        },
      },
    },
  },
}
