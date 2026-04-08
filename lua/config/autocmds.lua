do
  local group = augroup('user_buftype_lazy', {})
  autocmd('User', {
    pattern = 'VeryLazy',
    group = group,
    callback = function()
      local exec_event = utils.func.defer_wrap(function()
        nvim.exec_autocmds('User', { pattern = 'BuftypeLazy' })
      end, 250)
      --- If dashboard is open on startup, wait until we have a "normal"
      --- buffer open to run the event
      if Snacks.dashboard.status.opened then
        autocmd('BufEnter', {
          callback = function(t)
            --- Don't execute if 'buftype' is set
            if vim.bo[t.buf].buftype ~= '' then
              return
            end
            exec_event()
            return true --- Only execute the event once
          end,
        })
      else
        -- If dashboard isn't open, just run the event
        exec_event()
      end
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
