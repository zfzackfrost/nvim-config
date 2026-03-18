if vim.fn.has('nvim-0.12') == 1 then
  local function lsp_info()
    vim.cmd.checkhealth('vim.lsp')
  end
  nvim.create_user_command('LspInfo', lsp_info, {})
end
