local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

do
  local group = augroup('user_local_settings', {})
  autocmd({ 'BufWinEnter', 'BufEnter', 'BufRead' }, {
    group = group,
    command = 'LoadLocalSettings',
  })
end
do
  local group = augroup('user_lsp_hints', {})
  autocmd({ 'BufWinEnter', 'BufEnter', 'BufRead' }, {
    group = group,
    callback = function(t)
      local enable = vim.b.lsp_enable_hints
      if enable == nil then
        return
      end
      vim.lsp.inlay_hint.enable(enable, { bufnr = t.buf })
    end,
  })
end

do
  local group = augroup('user_resize_window', {})
  autocmd({ 'BufWinEnter' }, {
    group = group,
    callback = function()
      vim.defer_fn(function()
        if vim.bo.filetype == 'neo-tree' then
          vim.api.nvim_win_set_width(0, 28)
        end
      end, 50)
    end,
  })
end
do
  local group = augroup('user_autostart_server', {})
  autocmd({ 'BufWinEnter' }, {
    group = group,
    callback = function(args)
      if vim.b[args.buf].autostart_server then
        vim.cmd.StartServer({})
      end
    end,
  })
end
do
  local group = augroup('user_format', {})
  autocmd({ 'BufWritePre' }, {
    group = group,
    callback = function(args)
      if vim.b[args.buf].format_on_save then
        vim.cmd.Format({ bang = true })
      end
    end,
  })
end

do
  local group = augroup('user_views', {})
  autocmd({ 'BufWritePre', 'BufWinLeave' }, {
    group = group,
    callback = function(args)
      if vim.bo[args.buf].buftype == '' then
        pcall(vim.cmd.mkview)
      end
    end,
  })
  autocmd('BufWinEnter', {
    pattern = '*',
    group = group,
    command = 'silent! loadview',
  })
end
