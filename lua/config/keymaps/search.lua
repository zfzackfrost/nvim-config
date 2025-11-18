local wk = require('which-key')

local prefix = '<leader>s'

local function search_smart()
  Snacks.picker.smart()
end
local function search_recent()
  Snacks.picker.recent()
end
local function search_buffers()
  Snacks.picker.buffers()
end
local function search_help()
  Snacks.picker.help()
end
local function search_man()
  Snacks.picker.man()
end
local function search_picker()
  Snacks.picker()
end

wk.add({
  { '<Esc>', '<Cmd>nohlsearch<Cr>' },
  { prefix, group = 'search' },
  { '<leader><leader>', search_smart, desc = 'Search for buffer, recents, files' },
  { prefix .. 'r', search_recent, desc = 'Search for recent files' },
  { prefix .. 'b', search_buffers, desc = 'Search for buffer' },
  { prefix .. 'h', search_help, desc = 'Search for vim help' },
  { prefix .. 'm', search_man, desc = 'Search linux manual' },
  { prefix .. 'p', search_picker, desc = 'Search for Snacks picker' },
})
