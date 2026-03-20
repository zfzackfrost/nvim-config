return {
  {
    'nvim-mini/mini.operators',
    version = false,
    lazy = false,
    opts = {
      -- Exchange text regions
      exchange = {
        -- NOTE: Default `gx` is remapped to `gX`
        prefix = 'gx',
        reindent_linewise = true,
      },

      -- Replace text with register
      replace = {
        -- NOTE: Default `gr*` LSP mappings are removed
        prefix = 'gr',
        reindent_linewise = true,
      },

      -- Sort text
      sort = {
        prefix = 'gs',
      },

      -- Disabled: Multiply (duplicate) text
      multiply = {
        prefix = 'm',
      },

      -- Disabled: Evaluate text and replace with output
      evaluate = {
        prefix = '=',
      },
    },
  },
}
