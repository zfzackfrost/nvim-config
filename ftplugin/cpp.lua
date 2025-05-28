vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

local splitjoin = require('utils.mini.splitjoin')
local add_trailing_comment = splitjoin.gen.add_trailing_comment({
  brackets = { '%b()', '%b{}' },
})

-- Create buffer-local config
vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_trailing_comment } },
}
