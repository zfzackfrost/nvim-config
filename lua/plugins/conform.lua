return {
  'stevearc/conform.nvim',
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    formatters_by_ft = {
      arduino = { 'clang-format' },
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
}
