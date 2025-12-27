local wk = require('which-key')
local prefix = '<leader>'
local m = require('utils.vim.map')

local function search_files()
  Snacks.picker.files()
end

wk.add({
  { '<leader><leader>', search_files, desc = 'Search for files' },
  { prefix .. 'e', [[<Cmd>Neotree toggle<Cr>]], desc = 'File tree' },
  { prefix .. 'E', [[<Cmd>Neotree toggle reveal<Cr>]], desc = 'File tree (current file)' },
})
