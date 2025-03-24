local blink = require('blink.cmp')

---------------- Menu Components --------------

---@type blink.cmp.DrawComponent
local kind_icon = {
  ellipsis = false,
  text = function(ctx)
    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
    return kind_icon
  end,
  highlight = function(ctx)
    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
    return hl
  end,
}

------------------- Providers -----------------

local lazydev = {
  name = 'LazyDev',
  module = 'lazydev.integrations.blink',
  score_offset = 100, -- Top priority
}
local providers = {
  lazydev = lazydev,
}

-- ############################################################
-- ########################## Options #########################
-- ############################################################

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  snippets = { preset = 'luasnip' },
  keymap = { preset = 'enter' },
  appearance = {
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
          kind_icon = kind_icon,
        },
      },
    },
  },
  fuzzy = {
    sorts = {
      'exact',
      'score',
      'sort_text',
    },
  },
  signature = {
    enabled = true,
    trigger = {
      show_on_insert = true,
    },
  },
  cmdline = {},
  sources = {
    default = { 'lazydev', 'lsp', 'snippets', 'path', 'buffer' },
    providers = providers,
  },
}

-- ############################################################
-- ########################### Setup ##########################
-- ############################################################

blink.setup(opts)
