local trouble = require('trouble')
trouble.setup({
  auto_open = true, -- automatically open the list when you have diagnostics
  auto_close = true, -- automatically close the list when you have no diagnostics
  signs = {
    -- icons / text used for a diagnostic
    error = '',
    warning = '',
    hint = '',
    information = '',
    other = '',
  },
})
