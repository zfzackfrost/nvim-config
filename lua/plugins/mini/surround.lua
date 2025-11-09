return {
  {
    'nvim-mini/mini.surround',
    version = false,
    keys = {
      { 'sa', mode = { 'n', 'v' }, desc = 'Add surrounding' },
      { 'sr', mode = { 'n', 'v' }, desc = 'Replace surrounding' },
      { 'sd', mode = { 'n', 'v' }, desc = 'Delete surrounding' },
      { 'sf', mode = { 'n', 'v' }, desc = 'Find right surrounding' },
      { 'sF', mode = { 'n', 'v' }, desc = 'Find left surrounding' },
    },
    opts = {
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        replace = 'sr', -- Replace surrounding

        highlight = '', -- Highlight surrounding
        update_n_lines = '', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    },
  },
}
