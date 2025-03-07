return {
  {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = { 'LuaSnip' },
    event = { 'InsertEnter' },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = 'luasnip' },
      keymap = { preset = 'enter' },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = 'normal',
      },
      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        menu = {
          draw = {
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
      signature = {
        enabled = true,
      },
      cmdline = {},
      sources = {
        default = { 'lazydev', 'lsp', 'snippets', 'path', 'buffer' },

        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- Top priority
          },
        },
      },
    },
  },
}
