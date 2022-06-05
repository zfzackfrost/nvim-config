local m = Utils.map
m.group_name('n', '<Space>f', 'file-system')

m.group_name('n', '<Space>fm', 'make')
m.map('n', '<Space>fmd', [[<Cmd>Mkdir<Cr>]], { desc = 'Parent directories' })

m.map('n', '<Space>fe', [[<Cmd>NvimTreeToggle<Cr>]], { desc = 'File explorer' })
m.map('n', '<Space>fE', [[<Cmd>NvimTreeFindFileToggle<Cr>]], { desc = 'File explorer (current file)' })

m.group_name('n', '<Space>fx', 'unix-file-operation')
m.map('n', '<Space>fxr', ':Rename<Space>', { silent = false, desc = 'Rename (relative to current)' })
m.map('n', '<Space>fxd', '<Cmd>Remove!<Cr>', { silent = false, desc = 'Delete current file' })
m.map('n', '<Space>fxc', ':Duplicate<Space>', { silent = false, desc = 'Copy (relative to current)' })
m.map('n', '<Space>fxp', ':Chmod<Space>', { silent = false, desc = 'Change permissions' })
