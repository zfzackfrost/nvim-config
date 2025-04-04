return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        enabled = true,
        border = 'single',
        prefer_width = 50,
        relative = 'cursor',
        win_options = {
          sidescrolloff = 5,
        },
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
    },
  },
}
