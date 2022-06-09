vim.filetype.add({
  extension = {
    -- WGSL shader
    ['wgsl'] = 'wgsl',

    -- GLSL shaders
    ['vert'] = 'glsl',
    ['frag'] = 'glsl',
    ['geom'] = 'glsl',
    ['comp'] = 'glsl',
    ['tese'] = 'glsl',
    ['tesc'] = 'glsl',

    -- Oh My ZSH! Theme
    ['zsh-theme'] = 'zsh',
  },
  filename = {
    -- Git
    ['.gitignore'] = 'gitconfig',

    -- Markdown
    ['README'] = 'markdown',

    -- JSON
    ['.babelrc'] = 'json',
    ['.eslintrc'] = 'json',
    ['.prettierrc'] = 'json',

    -- YAML
    ['.clang-format'] = 'yaml',

    -- TOML
    ['Pipfile'] = 'toml',
  },
})
