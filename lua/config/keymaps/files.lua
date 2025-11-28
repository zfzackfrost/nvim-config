local wk = require('which-key')

local function select_filetype()
  local filetypes = vim.fn.getcompletion('', 'filetype')
  local current_ft = vim.bo.filetype
  vim.ui.select(filetypes, {
    prompt = 'Select filetype',
    snacks = {
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
    if item == nil then
      return
    end
    vim.bo.filetype = item
  end)
end

local prefix = '<leader>f'
wk.add({
  { prefix, group = 'files' },
  { prefix .. 'p', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory' },
  { prefix .. 't', select_filetype, desc = 'Select filetype' },
})
