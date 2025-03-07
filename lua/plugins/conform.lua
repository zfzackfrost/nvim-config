return {
  'stevearc/conform.nvim',
  lazy = true,
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      c = { 'clang-format' },
      cmake = { 'cmake_format' },
      cpp = { 'clang-format' },
      css = { 'prettier' },
      gdscript = { 'gdformat' },
      go = { 'goimports', 'gofmt' },
      html = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      python = { 'yapf' },
      scss = { 'prettier' },
      svelte = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      xml = { 'prettier' },
      zig = { 'zigfmt' },
    },
  },
  config = function(_, opts)
    require('conform').setup(opts)
  end,
}
