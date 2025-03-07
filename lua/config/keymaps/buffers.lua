local function make_bufdelete(force)
  return function()
    require('mini.bufremove').delete(0, force)
  end
end
local function bufonly()
  local all_bufs = vim.api.nvim_list_bufs()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(all_bufs) do
    if vim.bo[buf].buftype == '' and buf ~= current then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

local wk = require('which-key')
wk.add({
  { '<leader>bo', bufonly, desc = 'Delete buffers except current' },
  { '<leader>bd', make_bufdelete(false), desc = 'Delete buffer and keep split' },
  { '<leader>bD', make_bufdelete(true), desc = 'Delete buffer (force) and keep split' },
})
