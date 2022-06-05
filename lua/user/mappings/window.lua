local m = Utils.map

m.map('nit', '<A-h>', '<Cmd>wincmd h<Cr>', { desc = 'Nav split left' })
m.map('nit', '<A-j>', '<Cmd>wincmd j<Cr>', { desc = 'Nav split down' })
m.map('nit', '<A-k>', '<Cmd>wincmd k<Cr>', { desc = 'Nav split up' })
m.map('nit', '<A-l>', '<Cmd>wincmd l<Cr>', { desc = 'Nav split right' })

local match_buf = require('user.utils.buffer.match')
local smart_quit = function()
  local is_special_window = function(win)
    local buf = vim.api.nvim_win_get_buf(win)
    return match_buf(buf, {
      filetype = {
        '^help$',
        '^qf$',
        '^starter$',
        '^fugitive$',
        '^NvimTree$',
        '^Trouble$',
        '^Telescope%w*$',
      },
      buftype = {
        '^terminal$'
      },
    }, {})
  end

  local current_win = vim.api.nvim_get_current_win()
  local all_wins = vim.api.nvim_tabpage_list_wins(0)

  local can_quit
  if #all_wins > 1 then
    if is_special_window(current_win) then
      can_quit = true
    else
      can_quit = false
      for _, w in ipairs(all_wins) do
        if w ~= current_win then
          if not is_special_window(w) then
            can_quit = true
            break
          end
        end
      end
    end
  else
    can_quit = false
  end
  if can_quit then
    vim.cmd([[wincmd c]])
  end
end

m.map('n', 'q', smart_quit, { desc = 'Smart quit' })
