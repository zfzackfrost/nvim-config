vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4

local gen_hook = require('mini.splitjoin').gen_hook

local paren = { brackets = { '%b()' } }
local curly = { brackets = { '%b{}' } }
local brack = { brackets = { '%b[]' } }

-- Add trailing comma when splitting inside curly brackets, square brackets and parenthesis
local add_comma_curly = gen_hook.add_trailing_separator(curly)
local add_comma_paren = gen_hook.add_trailing_separator(paren)
local add_comma_brack = gen_hook.add_trailing_separator(brack)

-- Delete trailing comma when joining inside curly brackets, square brackets and parenthesis
local del_comma_curly = gen_hook.del_trailing_separator(curly)
local del_comma_paren = gen_hook.del_trailing_separator(paren)
local del_comma_brack = gen_hook.del_trailing_separator(brack)

-- Pad curly brackets with single space after join
local pad_curly = gen_hook.pad_brackets(curly)

-- Create buffer-local config
vim.b.minisplitjoin_config = {
  split = { hooks_post = { add_comma_curly, add_comma_paren, add_comma_brack } },
  join = { hooks_post = { del_comma_curly, del_comma_paren, del_comma_brack, pad_curly } },
}
