return {
  {
    'nvim-mini/mini.operators',
    version = false,
    lazy = false,
    opts = {
      -- Exchange text regions
      exchange = {
        prefix = 'gX',
        reindent_linewise = true,
      },

      -- Replace text with register
      replace = {
        prefix = 'gr',
        reindent_linewise = true,
      },

      -- Sort text
      sort = {
        prefix = 'gs',
      },

      -- Disabled: Multiply (duplicate) text
      multiply = {
        prefix = '',
      },

      -- Disabled: Evaluate text and replace with output
      evaluate = {
        prefix = '',
      },
    },
  },
}
