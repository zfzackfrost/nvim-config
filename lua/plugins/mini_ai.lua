return {
  {
    'echasnovski/mini.ai',
    dependencies = { 'nvim-treesitter-textobjects' },
    version = false,
    config = function()
      require('config.mini.ai')
    end,
  },
}
