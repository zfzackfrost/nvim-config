local wk = require('which-key')
local m = require('utils.vim.map')

local function list_command(mode)
  local args = mode
  return '<Cmd>Trouble ' .. args .. '<Cr>'
end
local prefix = '<leader>cn'
wk.add({
  { prefix, group = 'navigate', icon = {
    icon = '',
    color = 'purple',
  } },
  { prefix .. 't', list_command('lsp_type_definitions'), desc = 'Type definitions', mode = { 'n', 'v' } },
  { prefix .. 'i', list_command('lsp_implementations'), desc = 'Implementations', mode = { 'n', 'v' } },
  { prefix .. 'd', list_command('lsp_declarations'), desc = 'Declarations', mode = { 'n', 'v' } },
  { prefix .. 'D', list_command('lsp_definitions'), desc = 'Definitions', mode = { 'n', 'v' } },
  { prefix .. 'r', list_command('lsp_references'), desc = 'References', mode = { 'n', 'v' } },
})
