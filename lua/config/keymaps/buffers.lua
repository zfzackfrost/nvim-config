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

local function write_nofmt()
  local old_format_on_save = vim.b.format_on_save
  vim.b.format_on_save = false
  vim.cmd.write()
  vim.b.format_on_save = old_format_on_save
end

local prefix = '<leader>b'

local wk = require('which-key')
wk.add({
  { prefix, group = 'buffers' },
  { prefix .. 'o', bufonly, desc = 'Delete buffers except current' },
  { prefix .. 'e', [[<Cmd>edit<Cr>]], desc = "Re-open current buffer's file" },
  { prefix .. '<C-w>', write_nofmt, desc = 'Write buffer without formatting' },
  { prefix .. 'W', [[<Cmd>wall<Cr>]], desc = 'Write all buffers' },
  { prefix .. 'w', [[<Cmd>write<Cr>]], desc = 'Write current buffers' },
  { prefix .. 'd', make_bufdelete(false), desc = 'Delete buffer and keep split' },
  { prefix .. 'D', make_bufdelete(true), desc = 'Delete buffer (force) and keep split' },
})
