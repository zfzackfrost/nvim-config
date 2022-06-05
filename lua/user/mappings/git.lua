local m = Utils.map

m.group_name('n', '<Space>g', 'git')
m.map('n', '<Space>g<Space>', ':Git<Space>', {desc = 'Git command', silent = false})
m.map('n', '<Space>gs', '<Cmd>Git<Cr>', {desc = 'Git status'})

m.map_name('n', 'cc', 'Create commit', {ft = 'fugitive'})
m.map_name('n', 'ca', 'Amend commit and reword', {ft = 'fugitive'})
m.map_name('n', 'ce', 'Amend commit without reword', {ft = 'fugitive'})
m.map_name('n', 'cw', 'Reword last commit', {ft = 'fugitive'})
