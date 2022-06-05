local function buf_only()
  local view = vim.fn.winsaveview()
  vim.cmd('%bd')
  vim.cmd('e#')
  vim.cmd('bd#')
  vim.fn.winrestview(view)
end
local function buf_jump_number()
  vim.ui.input({
    prompt = 'Jump to buffer number: ',
  }, function(input)
    if input ~= nil then
      local buf = tonumber(vim.trim(input))
      if type(buf) == "number" then
        vim.cmd(string.format('LualineBuffersJump %d', buf))
      end
    end
  end)
end

local m = Utils.map
m.group_name('n', '<Space>b', 'buffer')

m.group_name('n', '<Space>bd', 'buffer-close')
m.map_name('n', { '<Space>bdd', '<Leader>c' }, 'Close current buffer')
m.map('n', '<Space>bdo', buf_only, { desc = 'Close other buffers' })

m.map('n', '<Space>ba', '<Cmd>buffer #<Cr>', { desc = 'Alternate buffer' })
m.map('n', '<Space>bj', buf_jump_number, { desc = 'Jump to buffer (input number)' })
m.map('n', ']b', '<Cmd>bnext<Cr>', { desc = 'Next buffer' })
m.map('n', '[b', '<Cmd>bNext<Cr>', { desc = 'Prev buffer' })
