---@alias LspFormatMode 'never'|'fallback'|'first'|'last'|'prefer'

---@class FiletypeSettings
---@field lsp_enable_hints? boolean If `true` enable inlay hints for this filetype. If `false` disable. If `nil`, do nothing.
---@field autostart_server? boolean If `true` start the Neovim server when opening this filetype.
---@field format_on_save? boolean If `true`, format files of this type before saving them.
---@field formatters? string|string[] If not `nil` override the defined formatters for this filetype.
---@field lsp_format? LspFormatMode If not `nil`, sets how the language server is used when formatting this filetype.

---@alias LocalSettings table<string, FiletypeSettings>
