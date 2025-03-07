return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      -- Adapters
      'lawrence-laz/neotest-zig',
      'alfaix/neotest-gtest',
    },
    lazy = true,
    opts = function()
      return {
        adapters = {
          require('rustaceanvim.neotest'),
          require('neotest-zig')({
            dap = {
              adapter = 'codelldb',
            },
          }),
          require('neotest-gtest').setup({}),
        },
      }
    end,
  },
}
