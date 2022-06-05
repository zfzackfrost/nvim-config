local M = {}

local make_opener = function(vertical, motion)
  local win_move_cmd = 'wincmd ' .. string.upper(motion)
  local split_cmd = vertical and 'vsplit' or 'split'
  return function(win_opts)
    win_opts = win_opts or {}
    local buffer = win_opts.buffer or vim.api.nvim_get_current_buf()

    local prev_win = vim.api.nvim_get_current_win()

    vim.cmd(split_cmd)
    vim.api.nvim_set_current_buf(buffer)

    vim.cmd(win_move_cmd)

    local handle = vim.api.nvim_get_current_win()
    if vertical then
      vim.api.nvim_win_set_width(handle, win_opts.size)
    else
      vim.api.nvim_win_set_height(handle, win_opts.size)
    end

    vim.api.nvim_set_current_win(prev_win)

    return handle
  end
end

M.top = make_opener(false, 'k')
M.bottom = make_opener(false, 'j')
M.right = make_opener(true, 'l')
M.left = make_opener(true, 'h')

return M
