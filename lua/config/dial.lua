local augend = require('dial.augend')
local common = require('dial.augend.common')
local config = require('dial.config')

local function extend(lists)
  local out = {}
  for _, l in ipairs(lists) do
    vim.list_extend(out, l)
  end
  return out
end

local dec_int = augend.integer.alias.decimal_int -- decimal number (..., -2, -1, 0, 1, 2, ...)

local markdown_check
do
  local checks = { ' ', 'x', '-' }

  local checks_str = ''
  for _, c in ipairs(checks) do
    checks_str = checks_str .. c
  end
  local check_pat = '(%s*%- %[)([' .. checks_str .. '])(].*)'
  markdown_check = augend.user.new({
    find = common.find_pattern(check_pat),
    add = function(text, addend, cursor)
      local pre, mark, suf = string.match(text, check_pat)
      if pre == nil then
        ---@diagnostic disable-next-line: redundant-return-value
        return { text = text, cursor = cursor }
      end
      local idx
      for i = 1, #checks, 1 do
        if checks[i] == mark then
          idx = i
          break
        end
      end
      idx = idx + addend
      if idx < 1 then
        idx = #checks
      elseif idx > #checks then
        idx = 1
      end
      mark = checks[idx]
      text = pre .. mark .. suf
      cursor = #text
      ---@diagnostic disable-next-line: redundant-return-value
      return { text = text, cursor = cursor }
    end,
  })
end

local js_let_const = augend.constant.new({
  elements = { 'let', 'const' },
  word = true,
  cyclic = true,
})
local hex_under = augend.integer.new({
  radix = 16,
  prefix = '0x',
  delimiter = '_',
  natural = true,
})
local oct_under = augend.integer.new({
  radix = 8,
  prefix = '0o',
  delimiter = '_',
  natural = true,
})
local bin_under = augend.integer.new({
  radix = 2,
  prefix = '0b',
  delimiter = '_',
  natural = true,
})
local dec_under = augend.integer.new({
  radix = 10,
  delimiter = '_',
  natural = false,
})

local hex_a_js = augend.integer.new({
  radix = 16,
  prefix = '0x',
  delimiter = "'",
  natural = true,
})
local hex_b_js = augend.integer.new({
  radix = 16,
  prefix = '0X',
  delimiter = "'",
  natural = true,
})
local oct_a_js = augend.integer.new({
  radix = 8,
  prefix = '0o',
  delimiter = "'",
  natural = true,
})
local oct_b_js = augend.integer.new({
  radix = 8,
  prefix = '0O',
  natural = true,
})
local oct_c_js = augend.integer.new({
  radix = 8,
  prefix = '0',
  natural = true,
})
local bin_a_js = augend.integer.new({
  radix = 2,
  prefix = '0b',
  natural = true,
})
local bin_b_js = augend.integer.new({
  radix = 2,
  prefix = '0B',
  natural = true,
})

local js_augends = {
  dec_int,
  hex_a_js,
  hex_b_js,
  oct_a_js,
  oct_b_js,
  oct_c_js,
  bin_a_js,
  bin_b_js,
  js_let_const,
  augend.constant.alias.bool,
}
local json_augends = {
  dec_int,
  augend.constant.alias.bool,
}

local dec_c = augend.integer.new({
  radix = 10,
  delimiter = "'",
  natural = false,
})
local hex_c = augend.integer.new({
  radix = 16,
  prefix = '0x',
  delimiter = "'",
  natural = true,
})
local oct_c = augend.integer.new({
  radix = 8,
  prefix = '0o',
  delimiter = "'",
  natural = true,
})
local bin_c = augend.integer.new({
  radix = 2,
  prefix = '0b',
  delimiter = "'",
  natural = true,
})

local default_augends = {
  dec_int,
}

local c_augends = {
  dec_c,
  hex_c,
  oct_c,
  bin_c,
}

local scope_cmake = augend.constant.new({
  elements = { 'PUBLIC', 'PRIVATE', 'INTERFACE' },
  word = true,
  cyclic = true,
})
local libtype_cmake = augend.constant.new({
  elements = { 'SHARED', 'STATIC' },
  word = true,
  cyclic = true,
})

local bool_a_cmake = augend.constant.new({
  elements = { 'TRUE', 'FALSE' },
  word = true,
  cyclic = true,
})
local bool_b_cmake = augend.constant.new({
  elements = { 'ON', 'OFF' },
  word = true,
  cyclic = true,
})
local bool_c_cmake = augend.constant.new({
  elements = { 'YES', 'NO' },
  word = true,
  cyclic = true,
})

local css_augends = {
  augend.integer.alias.decimal,
  augend.hexcolor,
}

config.augends:on_filetype({
  cpp = extend({
    c_augends,
    { augend.constant.alias.bool },
  }),
  c = c_augends,
  cmake = extend({
    default_augends,
    {
      scope_cmake,
      libtype_cmake,
      bool_a_cmake,
      bool_b_cmake,
      bool_c_cmake,
    },
  }),
  markdown = {
    dec_int,
    markdown_check,
    augend.misc.alias.markdown_header,
  },
  rust = {
    dec_under,
    hex_under,
    oct_under,
    bin_under,
    augend.constant.alias.bool,
  },
  lua = {
    dec_int,
    augend.constant.alias.bool,
  },
  json = extend({ { augend.semver.alias.semver }, json_augends }),
  jsonc = json_augends,
  toml = {
    augend.semver.alias.semver,
    dec_under,
    hex_under,
    oct_under,
    bin_under,
    augend.constant.alias.bool,
  },
  yaml = {
    augend.semver.alias.semver,
    dec_under,
    hex_under,
    oct_under,
    bin_under,
    augend.constant.alias.bool,
  },
  python = {
    dec_int,
    augend.constant.alias.Bool,
  },
  javascript = js_augends,
  typescript = js_augends,
  javascriptreact = js_augends,
  typescriptreact = js_augends,
  svelte = extend({ js_augends, css_augends }),

  css = css_augends,
  scss = css_augends,
  less = css_augends,

  dosini = {
    dec_int,
    augend.constant.alias.bool,
  },
})
config.augends:register_group({
  default = default_augends,
})
