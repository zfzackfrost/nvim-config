return function()
  require('cmp_dictionary').setup({
    dic = {
      ['*'] = { vim.fn.stdpath('config') .. '/dict.txt' },
    },
    async = true,
  })
end
