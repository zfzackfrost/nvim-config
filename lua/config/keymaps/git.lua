local m = utils.vim.map

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  direction = 'tab',
  close_on_exit = true,
  on_open = function(term)
    local function unmap_esc()
      vim.keymap.del('t', '<Esc><Esc>', {
        buf = term.bufnr,
      })
    end
    vim.defer_fn(function()
      pcall(unmap_esc)
    end, 100)
    vim.cmd('startinsert!')
  end,
})

local prefix = '<leader>g'
local prefix_add = prefix .. 'a'
local prefix_commit = prefix .. 'c'
local prefix_reset = prefix .. 'r'

---@type wk.Icon
local git_icon = {
  icon = '',
  color = 'red',
}

local function lazygit_open()
  lazygit:toggle()
end

vim.keymap.set('n', prefix .. '<Space>', function()
  return [[:Git ]]
end, {
  expr = true,
  replace_keycodes = true,
  desc = 'Git operation',
})

m.add_with_icon({
  { prefix, group = 'git' },

  { prefix .. 'g', lazygit_open, desc = 'Lazygit open' },

  { prefix_add, group = 'add' },
  { prefix_add .. 'a', [[<Cmd>Git add --all<Cr>]], desc = 'Add all' },
  { prefix_add .. 'f', [[<Cmd>Git add %<Cr>]], desc = 'Add current file' },
  { prefix_add .. 'h', [[<Cmd>Gitsigns stage_hunk<Cr>]], desc = 'Add hunk' },

  { prefix_commit, group = 'commit' },
  { prefix_commit .. 'c', [[<Cmd>Git commit<Cr>]], desc = 'Commit staged' },

  { prefix_reset, group = 'reset' },
  { prefix_reset .. 'h', [[<Cmd>Gitsigns reset_hunk<Cr>]], desc = 'Reset hunk' },
}, git_icon)
