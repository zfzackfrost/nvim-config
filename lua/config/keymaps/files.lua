local wk = require('which-key')

local function select_filetype()
  local filetypes = vim.fn.getcompletion('', 'filetype')
  vim.ui.select(filetypes, {
    prompt = 'Select filetype',
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
