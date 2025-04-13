local blink = require('blink.cmp')

--------------- Enable Completion -------------

local disabled_fts = {}
local function blink_enabled()
  return not vim.tbl_contains(disabled_fts, vim.bo.filetype)
end

---------------- Menu Components --------------

---@type blink.cmp.DrawComponent
local kind_icon = {
  ellipsis = false,
  text = function(ctx)
    if ctx.item.client_name == 'tailwindcss' and ctx.kind == 'Color' then
      return ctx.kind_icon
    end
    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
    return kind_icon
  end,
  highlight = function(ctx)
    if ctx.item.client_name == 'tailwindcss' and ctx.kind == 'Color' then
      return ctx.kind_hl
    end
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
local nerdfont = {
  module = 'blink-nerdfont',
  name = 'Nerd Fonts',
  score_offset = 10,
  opts = { insert = true },
}
local providers = {
  lazydev = lazydev,
  nerdfont = nerdfont,
}

-------------------- Sources ------------------

local sources = {
  default = { 'lsp', 'snippets', 'path', 'buffer' },
  per_filetype = {
    lua = {
      'lazydev',
      'lsp',
      'snippets',
      'path',
      'buffer',
      'nerdfont',
    },
  },
  providers = providers,
}

-- ############################################################
-- ########################## Options #########################
-- ############################################################

---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  enabled = blink_enabled,
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
      show_on_insert_on_trigger_character = true,
      show_on_trigger_character = true,
    },
  },
  cmdline = {},
  sources = sources,
}

-- ############################################################
-- ########################### Setup ##########################
-- ############################################################

blink.setup(opts)
