local m = require('user.utils.map')

local function setup_formatting(client, bufnr)
  local function formatting_callback()
    local params = vim.lsp.util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end

  m.map('n', '<Space>lf', formatting_callback, { desc = 'Format document', buffer = bufnr })
  vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', formatting_callback, { bang = true, bar = true })
end

return function(enable_format)
  return function(client, bufnr)
    m.group_name('nv', '<Space>l', 'lsp', { buffer = bufnr })

    if enable_format then
      setup_formatting(client, bufnr)
    end

    m.group_name('n', '<Space>ls', 'lsp-search', { buffer = bufnr })
    m.map(
      'n',
      '<Space>lsw',
      '<Cmd>Telescope lsp_dynamic_workspace_symbols<Cr>',
      { desc = 'Rename symbol', buffer = bufnr }
    )

    m.map('n', '<Space>lr', '<Cmd>lua vim.lsp.buf.rename()<Cr>', { desc = 'Rename symbol', buffer = bufnr })
    m.map('n', '<Space>la', '<Cmd>lua vim.lsp.buf.code_action()<Cr>', { desc = 'Code action', buffer = bufnr })
    m.map('n', '<Space>lR', '<Cmd>LspRestart<Cr>', { desc = 'Restart LSP clients', buffer = bufnr })

    m.group_name('n', '<Space>lw', 'lsp-workspace', { buffer = bufnr })
    m.map(
      'n',
      '<Space>lwa',
      '<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>',
      { desc = 'Add workspace folder', buffer = bufnr }
    )
    m.map(
      'n',
      '<Space>lwr',
      '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>',
      { desc = 'Remove workspace folder', buffer = bufnr }
    )

    m.group_name('n', '<Space>sl', 'search-lsp', { buffer = bufnr })
    m.map(
      'n',
      '<Space>sls',
      '<Cmd>Telescope lsp_dynamic_workspace_symbols<Cr>',
      { desc = 'Workspace symbol (fuzzy)', buffer = bufnr }
    )

    m.group_name('nv', '<Space>lg', 'lsp-goto', { buffer = bufnr })
    m.map('nv', '<Space>lgd', '<Cmd>Telescope lsp_definitions<Cr>', { desc = 'Goto definition', buffer = bufnr })
    m.map(
      'nv',
      '<Space>lgi',
      '<Cmd>Telescope lsp_implementations<Cr>',
      { desc = 'Goto implementation', buffer = bufnr }
    )
    m.map(
      'nv',
      '<Space>lgt',
      '<Cmd>Telescope lsp_type_definitions<Cr>',
      { desc = 'Goto type definition', buffer = bufnr }
    )

    m.map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', { desc = 'LSP hover', buffer = bufnr })
    m.map('iv', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', { desc = 'LSP signature help', buffer = bufnr })

    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
  end
end
