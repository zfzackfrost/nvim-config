return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    lazy = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzf-native.nvim',
    },
    cmd = { 'Telescope' },
    opts = {
      extensions = {
        file_browser = {
          theme = 'ivy',
          hijack_netrw = true,
          mappings = {
            i = {},
            n = {},
          },
        },
      },
    },
    config = function(_, opts)
      local t = require('telescope')
      t.setup(opts)
      t.load_extension('fzf')
    end,
  },
}
