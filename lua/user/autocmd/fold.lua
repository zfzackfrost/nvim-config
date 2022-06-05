local match_buffer = require('user.utils.buffer.match')

local include = {
  filetype = {
    '^lua$',
    '^rust$',
    '^html$',
    '^[s]?css$',
    '^cpp$',
    '^c$',
    '^cs$',
    '^[c]?make$',
    '^java$',
    '^kotlin$',
    '^python$',
    '^toml$',
    '^yaml$',
    '^[h]?json[c5]?$',
    '^javascript%w*$',
    '^typescript%w*$',
    '^wgsl$',
    '^glsl$',
  },
}

local function disable_ts_fold()
  vim.wo.foldmethod = 'indent'
end

local function enable_ts_fold()
  if match_buffer(0, include, {}) then
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
  else
    disable_ts_fold()
  end
end

local group = vim.api.nvim_create_augroup('user_ts_fold', {})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = group,
  callback = vim.schedule_wrap(enable_ts_fold),
})
