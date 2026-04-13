local wk = require('which-key')

local function select_filetype()
  -- Get all registered filetypes
  local filetypes = vim.fn.getcompletion('', 'filetype')
  local current_ft = vim.bo.filetype
  local current_buf = nvim.get_current_buf()
  vim.ui.select(filetypes, {
    prompt = 'Select filetype',
    snacks = {
      -- Scroll to current filetype on show
      on_show = function(picker)
        local idx = nil
        for i = 1, picker:count() do
          if filetypes[i] == current_ft then
            idx = i
            break
          end
        end
        if idx ~= nil then
          picker.list:set_target(idx)
        end
      end,
    },
  }, function(item)
    if item ~= nil then
      vim.bo[current_buf].filetype = item
    end
  end)
end

local prefix = '<leader>f'

vim.keymap.set('n', prefix .. 'n', function()
  return [[:NewFile ]]
end, {
  desc = 'New file(s)',
  expr = true,
  replace_keycodes = true,
})

---@type wk.Icon
local newfile_icon = {
  icon = '󰝒',
  color = 'green',
}
---@type wk.Icon
local newdir_icon = {
  icon = '󰉗',
  color = 'green',
}
---@type wk.Icon
local executable_icon = {
  icon = '󱁻',
  color = 'blue',
}
---@type wk.Icon
local list_icon = {
  icon = '󰉹',
  color = 'orange',
}

wk.add({
  { prefix, group = 'files' },
  { prefix .. 'n', icon = newfile_icon },
  { prefix .. 'p', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory', icon = newdir_icon },
  { prefix .. 't', select_filetype, desc = 'Select filetype', icon = list_icon },
  { prefix .. 'x', [[<Cmd>Chmod +x<Cr>]], desc = 'Set executable permission', icon = executable_icon },
})
