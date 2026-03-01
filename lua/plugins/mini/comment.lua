return {
  {
    'nvim-mini/mini.comment',
    version = false,
    keys = {
      { 'gc', desc = 'Comment', mode = { 'n', 'x' } },
      { 'gc', desc = 'Comment textobject', mode = { 'o' } },
    },
    opts = {
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        comment_visual = 'gc',
        textobject = 'gc',
      },
    },
  },
}
