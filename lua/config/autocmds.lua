do
  local group = augroup('user_filetype_lazy', {})
  local ignore_ft_list = {
    'lazy',
    'snacks_picker_input',
    'neo-tree',
    '',
  }
  autocmd('User', {
    pattern = 'FiletypeLazy',
    callback = function()
      -- print('OK!')
    end,
  })
  autocmd('User', {
    pattern = 'VeryLazy',
    group = group,
    callback = function()
      local all_bufs = nvim.list_bufs()
      local dashboard_buf
      for _, b in ipairs(all_bufs) do
        if vim.bo[b].filetype == 'snacks_dashboard' then
          dashboard_buf = b
          break
        end
      end
      if dashboard_buf ~= nil then
        autocmd('BufWinEnter', {
          callback = function(t)
            if t.buf ~= dashboard_buf and not vim.list_contains(ignore_ft_list, vim.bo[t.buf].filetype) then
              nvim.exec_autocmds('User', { pattern = 'FiletypeLazy' })
              return true
            end
          end,
        })
      else
        vim.defer_fn(function()
          nvim.exec_autocmds('User', { pattern = 'FiletypeLazy' })
        end, 250)
      end
      return true
    end,
  })
end
do
  local group = augroup('user_treesitter', {})
  autocmd({ 'BufWinEnter' }, {
    group = group,
    callback = function(ev)
      pcall(vim.treesitter.start, ev.buf)
    end,
  })
end
do
  local group = augroup('user_local_settings', {})
  autocmd({ 'BufWinEnter', 'BufEnter', 'BufRead' }, {
    group = group,
    command = 'LoadLocalSettings',
  })
end
do
  local group = augroup('user_diagnostics', {})
  autocmd({ 'BufWinEnter', 'BufEnter', 'BufRead' }, {
    group = group,
    callback = function(t)
      local enable = vim.b.diagnostics_disabled
      if enable == nil then
        return
      end
      vim.diagnostic.enable(not vim.b.diagnostics_disabled, { bufnr = t.buf })
    end,
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
