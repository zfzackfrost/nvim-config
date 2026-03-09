local lazy = {}

--- Require on index.
---
--- Will only require the module after the first index of a module.
--- Only works for modules that export a table.
function lazy.on_index(require_path, callback)
  return setmetatable({}, {
    __index = function(_, key)
      local mod = require(require_path)
      if callback ~= nil then
        callback(mod)
      end
      return mod[key]
    end,

    __newindex = function(_, key, value)
      local mod = require(require_path)
      if callback ~= nil then
        callback(mod)
      end
      mod[key] = value
    end,
  })
end

--- Requires only when you call the _module_ itself.
---
--- If you want to require an exported value from the module,
--- see instead |lazy.on_exported_call()|
function lazy.on_module_call(require_path)
  return setmetatable({}, {
    __call = function(_, ...)
      return require(require_path)(...)
    end,
  })
end

--- Require when an exported method is called.
---
--- Creates a new function. Cannot be used to compare functions,
--- set new values, etc. Only useful for waiting to do the require until you actually
--- call the code.
---
--- <pre>
--- -- This is not loaded yet
--- local lazy_mod = lazy.on_exported_call('my_module')
--- local lazy_func = lazy_mod.exported_func
---
--- -- ... some time later
--- lazy_func(42)  -- <- Only loads the module now
---
--- </pre>
function lazy.on_exported_call(require_path)
  return setmetatable({}, {
    __index = function(_, k)
      return function(...)
        return require(require_path)[k](...)
      end
    end,
  })
end

return lazy
