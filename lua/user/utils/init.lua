_G.Utils = _G.Utils or {}

_G.Utils.lazy = require('user.utils.lazy')

_G.Utils.core = _G.Utils.lazy.require_on_exported_call('user.utils.core')

_G.Utils.yaml = _G.Utils.lazy.require_on_exported_call('lyaml')
_G.Utils.json = _G.Utils.lazy.require_on_exported_call('cjson')

_G.Utils.functional = require('user.utils.functional')

_G.Utils.tbl = _G.Utils.lazy.require_on_exported_call('user.utils.tbl')

_G.Utils.string = _G.Utils.lazy.require_on_exported_call('user.utils.string')
_G.Utils.strcase = _G.Utils.lazy.require_on_exported_call('user.utils.string.case')

_G.Utils.Buffer = require('user.utils.buffer')
_G.Utils.Window = require('user.utils.window')

_G.Utils.bit = _G.Utils.lazy.require_on_exported_call('user.utils.bit')
_G.Utils.fs = _G.Utils.lazy.require_on_index('user.utils.fs')
_G.Utils.glob = _G.Utils.lazy.require_on_exported_call('user.utils.string.glob')
_G.Utils.map = _G.Utils.lazy.require_on_exported_call('user.utils.map')
_G.Utils.vim = _G.Utils.lazy.require_on_exported_call('user.utils.vim')
