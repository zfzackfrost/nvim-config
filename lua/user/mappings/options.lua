local m = Utils.map

local native_option_map = function(lhs, opt)
  m.map('n', 'yo' .. lhs, ('<Cmd>setlocal %s!|setlocal %s?<Cr>'):format(opt, opt), { desc = ('Toggle %s'):format(opt) })
  m.map('n', '[o' .. lhs, ('<Cmd>setlocal %s|setlocal %s?<Cr>'):format(opt, opt), { desc = ('Enable %s'):format(opt) })
  m.map(
    'n',
    ']o' .. lhs,
    ('<Cmd>setlocal no%s|setlocal %s?<Cr>'):format(opt, opt),
    { desc = ('Disable %s'):format(opt) }
  )
end

m.group_name('n', 'yo', 'toggle-option')
m.group_name('n', '[o', 'enable-option')
m.group_name('n', ']o', 'disable-option')

native_option_map('n', 'number')
native_option_map('r', 'relativenumber')
native_option_map('l', 'list')
native_option_map('w', 'wrap')
