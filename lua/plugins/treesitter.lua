return {
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'typescriptreact',
      'javascriptreact',
      'xml',
      'vue',
      'svelte',
      'php',
      'html',
      'markdown',
    },
    opts = {},
  },
  {
    'zfzackfrost/nvim-treesitter-context',
    event = 'User BuftypeLazy',
    opts = {},
  },
  {
    'zfzackfrost/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    opts = {},
    config = function(_, opts)
      local ts = require('nvim-treesitter')
      ts.setup(opts)
    end,
  },
}
