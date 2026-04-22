return {
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '*',
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require('config.lsp.attach').on_attach({ buf = bufnr })
          end,
          cmd = {
            'rustup',
            'run',
            'nightly',
            'rust-analyzer',
          },
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                buildScripts = { enable = true },
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      }
    end,
  },
}
