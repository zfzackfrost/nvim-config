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
    if item == nil then
      return -- Do nothing if canceled
    end
    -- Set filetype of current_buf
    vim.bo[current_buf].filetype = item
  end)
end

local prefix = '<leader>f'
wk.add({
  { prefix, group = 'files' },
  { prefix .. 'p', [[:!mkdir -p %:p:h<Cr>]], desc = 'Make parent directory' },
  { prefix .. 't', select_filetype, desc = 'Select filetype' },
})
