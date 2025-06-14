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

---@param all? boolean
local function make_write_nofmt(all)
  return function()
    local old_format_on_save = vim.b.format_on_save
    vim.b.format_on_save = false
    if all then
      vim.cmd.wall()
    else
      vim.cmd.write()
    end
    vim.b.format_on_save = old_format_on_save
  end
end

local prefix = '<leader>b'

local wk = require('which-key')
wk.add({
  { prefix, group = 'buffers' },
  { prefix .. 'o', bufonly, desc = 'Delete buffers except current' },
  { prefix .. 'e', [[<Cmd>edit<Cr>]], desc = "Re-open current buffer's file" },
  { prefix .. '<C-w>', make_write_nofmt(false), desc = 'Write current buffer without formatting' },
  { prefix .. '<M-w>', make_write_nofmt(true), desc = 'Write all buffers without formatting' },
  { prefix .. 'W', [[<Cmd>wall<Cr>]], desc = 'Write all buffers' },
  { prefix .. 'w', [[<Cmd>write<Cr>]], desc = 'Write current buffers' },
  { prefix .. 'd', make_bufdelete(false), desc = 'Delete buffer and keep split' },
  { prefix .. 'D', make_bufdelete(true), desc = 'Delete buffer (force) and keep split' },
})
