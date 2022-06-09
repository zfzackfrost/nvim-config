require('user.utils')

require('user.options')
require('user.gui')

require('user.autocmd.colorscheme')
require('user.autocmd.cursorline')
require('user.autocmd.fold')

require('user.plugins')
require('packer.luarocks').setup_paths()

require('user.icons.webdev').setup()
require('user.icons.symbolic').setup()

require('user.notify')

require('user.which-key')
require('user.lualine')
require('user.colors')

require('user.editorconfig')
require('user.project')

require('user.lazy-plugins.luasnip')()
require('user.lazy-plugins.cmp')()
require('user.lazy-plugins.cmp_dictionary')()
require('user.lazy-plugins.lsp').setup()

require('user.views')
require('user.treesitter')
require('user.comment')
require('user.indent_blankline')
require('user.telescope')
require('user.gitsigns')
require('user.diagnostic').setup()

require('user.mappings.core')

require('user.mappings.bracket')
require('user.mappings.buffer')
require('user.mappings.file')
require('user.mappings.git')
require('user.mappings.lazy-plugins.mini_surround')
require('user.mappings.options')
require('user.mappings.quit')
require('user.mappings.search')
require('user.mappings.swap')
require('user.mappings.terminal')
require('user.mappings.textobj')
require('user.mappings.user-config')
require('user.mappings.window')
