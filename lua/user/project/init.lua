_G.Project = _G.Project or {}

_G.Project.root = require('user.project.root')

require('user.project.local_config').setup()
require('user.project.tasks.telescope').setup()

_G.Project.registry = require('user.project.registry')
_G.Project.registry.setup()
require('user.project.registry.telescope').setup()
