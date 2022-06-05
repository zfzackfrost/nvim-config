local match_buffer = require('user.utils.buffer.match')
local fs = require('user.utils.fs')


local exclude = {
  filetype = {
    '^help$',
    '^qf$',
    '^starter$',
    '^NvimTree$',
    '^Trouble$',
    '^Telescope%w*$',
  },
  buftype = {
    "^nofile$",
    "^terminal$",
  },
  name = {
    "^%s*$"
  }
}

local function save_view()
  if match_buffer(0, {}, exclude) then
    vim.cmd('mkview')
  end
end

local function load_view()
  if match_buffer(0, {}, exclude) then
    vim.cmd('silent! loadview')
  end
end

local group = vim.api.nvim_create_augroup('user_auto_views', {})
vim.api.nvim_create_autocmd({'BufWinLeave', 'BufWritePre'}, {
  group = group,
  callback = vim.schedule_wrap(save_view),
})
vim.api.nvim_create_autocmd({'BufWinEnter', 'BufReadPost'}, {
  group = group,
  callback = load_view,
})

local function clean_view_dir()
  local dir = vim.go.viewdir
  local view_files = fs.tree(dir)
  local count = 0
  for _, f in ipairs(view_files) do
    vim.fn.delete(f)
    count = count + 1
  end
  print(("Deleted %d view file(s)"):format(count))
end
vim.api.nvim_create_user_command('CleanViewDir', clean_view_dir, {bar = true})
