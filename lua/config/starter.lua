local str = require('utils.str')
local header = [[
 __    _  _______  _______  __   __  ___   __   __
|  |  | ||       ||       ||  | |  ||   | |  |_|  |
|   |_| ||    ___||   _   ||  |_|  ||   | |       |
|       ||   |___ |  | |  ||       ||   | |       |
|  _    ||    ___||  |_|  ||       ||   | |       |
| | |   ||   |___ |       | |     | |   | | ||_|| |
|_|  |__||_______||_______|  |___|  |___| |_|   |_|
]]
header = str.trimchars(header, '\n')

local function custom_actions()
  return {
    { name = 'e. Edit new buffer', action = 'enew', section = 'Actions' },
    { name = 'l. Run Lazy', action = 'Lazy', section = 'Actions' },
    { name = 'q. Quit Neovim', action = 'qall', section = 'Actions' },
  }
end

local starter = require('mini.starter')
starter.setup({
  header = header,
  evaluate_single = true,
  items = {
    custom_actions(),
    starter.sections.recent_files(10, true),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    starter.gen_hook.indexing('all', { 'Actions' }),
    starter.gen_hook.aligning('center', 'center'),
  },
})
