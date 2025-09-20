local wk = require('which-key')
local m = require('utils.vim.map')

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  direction = 'tab',
  close_on_exit = true,
  on_open = function(term)
    vim.cmd('startinsert!')
  end,
})

local prefix = '<leader>g'
local prefix_add = prefix .. 'a'
local prefix_commit = prefix .. 'c'
local prefix_hunk = prefix .. 'h'

---@type wk.Icon
local git_icon = {
  icon = '',
  color = 'red',
}

local function lazygit_open()
  lazygit:toggle()
end

m.add_with_icon({
  { prefix, group = 'git' },

  { prefix .. 'g', lazygit_open, desc = 'Lazygit Open' },

  { prefix_add, group = 'add' },
  { prefix_add .. 'a', [[<Cmd>Git add --all<Cr>]], desc = 'Add all' },
  { prefix_add .. 'f', [[<Cmd>Git add %<Cr>]], desc = 'Add current file' },

  { prefix_commit, group = 'commit' },
  { prefix_commit .. 'c', [[<Cmd>Git commit<Cr>]], desc = 'Commit' },
  { prefix_hunk, group = 'hunk' },
  { prefix_hunk .. 'r', [[<Cmd>Gitsigns reset_hunk<Cr>]], desc = 'Reset hunk' },
  { prefix_hunk .. 'a', [[<Cmd>Gitsigns stage_hunk<Cr>]], desc = 'Add/stage hunk' },
}, git_icon)
