local m = Utils.map

local prefix = '<Space>U'
m.group_name('n', prefix, 'user-nvim-config')
require('user.mappings.user-config.packer')(prefix)
require('user.mappings.user-config.views')(prefix)
