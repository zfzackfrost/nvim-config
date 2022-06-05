return function()
  require('crates').setup({})
  local group = vim.api.nvim_create_augroup('user_plugin_crates', {})

  Utils.map.map('n', '<Space>lcd', [[<Cmd>lua require('crates').open_documentation()<Cr>]], {desc = "Open crate docs", buffer = 0})
  Utils.map.map('n', '<Space>lci', [[<Cmd>lua require('crates').open_crates_io()<Cr>]], {desc = "Open crates.io page", buffer = 0})
  Utils.map.map('n', '<Space>lcr', [[<Cmd>lua require('crates').open_repository()<Cr>]], {desc = "Open crate repo", buffer = 0})
end
