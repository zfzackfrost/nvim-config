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
      'orjangj/neotest-ctest',
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
          require('neotest-ctest').setup({}),
        },
      }
    end,
  },
}
