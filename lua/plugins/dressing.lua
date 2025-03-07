return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = function()
      return {
        input = {
          enabled = false,
        },
        select = {
          enabled = true,
          backend = 'telescope',
          get_config = function(opts)
            local res = {}
            local themes = require('telescope.themes')
            if opts.kind == 'codeaction' then
              res.telescope = themes.get_cursor()
            else
              res.telescope = themes.get_dropdown()
            end
            return res
          end,
        },
      }
    end,
  },
}
