local function make_bufdelete(force)
  return function()
    require('mini.bufremove').delete(0, force)
  end
end
local function bufonly()
  local all_bufs = nvim.list_bufs()
  local current = nvim.get_current_buf()
  for _, buf in ipairs(all_bufs) do
    if vim.bo[buf].buftype == '' and buf ~= current then
      nvim.buf_delete(buf, {})
    end
  end
end

---@param all? boolean
local function buf_disable_format(all)
  if not all then
    vim.b.old_format_on_save = vim.b.format_on_save
    vim.b.format_on_save = false
    return
  end
  local bufs = nvim.list_bufs()
  for _, b in ipairs(bufs) do
    vim.b[b].old_format_on_save = vim.b[b].format_on_save
    vim.b[b].format_on_save = false
  end
end

---@param all? boolean
local function buf_enable_format(all)
  if not all then
    vim.b.format_on_save = vim.b.old_format_on_save
    vim.b.old_format_on_save = nil
    return
  end
  local bufs = nvim.list_bufs()
  for _, b in ipairs(bufs) do
    vim.b[b].format_on_save = vim.b[b].old_format_on_save
    vim.b[b].old_format_on_save = nil
  end
end

---@param all? boolean
local function make_write_nofmt(all)
  return function()
    buf_disable_format(all)
    if all then
      vim.cmd.wall()
    else
      vim.cmd.write()
    end
    buf_enable_format(all)
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
