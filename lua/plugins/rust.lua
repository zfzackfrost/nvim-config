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
    version = '^5',
    lazy = false,
    init = function()
      vim.g.rustaceanvim = {
        server = {
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
