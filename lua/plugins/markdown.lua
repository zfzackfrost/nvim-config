return {
  {
    'iamcco/markdown-preview.nvim',
    init = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    event = 'VeryLazy',
    build = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyLoad',
        callback = function(args)
          if args.data == 'markdown-preview.nvim' then
            vim.fn['mkdp#util#install']()
            return true
          end
        end,
      })
    end,
  },
}
