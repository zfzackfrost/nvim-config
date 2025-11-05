---Format command function
---@param args vim.api.keyset.create_user_command.command_args
local function format(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end
  local lsp_format = vim.b.lsp_format
  if lsp_format == nil then
    lsp_format = 'fallback'
  end
  require('conform').format({
    async = not args.bang,
    lsp_format = lsp_format,
    formatters = vim.b.formatters,
    range = range,
  })
end
nvim.create_user_command('Format', format, { bang = true, range = true })
