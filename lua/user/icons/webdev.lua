local M = {}

local config_icon = ''

local zsh_color = '#89E051'

local markdown_color = '#519ABA'
local markdown_icon = ''

local license_color = '#CBCB41'
local license_icon = ''

local shader_color = '#C08C6D'
local shader_icon_mixed = ''
local shader_icon_vert = '艹'
local shader_icon_frag = ''
local shader_icon_geom = '謁'
local shader_icon_comp = 'ﬧ'
local shader_icon_tesc = ''
local shader_icon_tese = ''

local function setup_icons()
  local devicons = require('nvim-web-devicons')
  devicons.setup({
    override = {

      -- Repository License file
      ['LICENSE'] = {
        icon = license_icon,
        color = license_color,
        name = 'License',
      },
      ['LICENSE.txt'] = {
        icon = license_icon,
        color = license_color,
        name = 'LicenseTxt',
      },
      -- Repository License file
      ['LICENSE.md'] = {
        icon = license_icon,
        color = license_color,
        name = 'LicenseMd',
      },

      -- Zsh
      ['zsh-theme'] = {
        icon = config_icon,
        color = zsh_color,
        name = 'ZshTheme',
      },

      -- Markdown file
      md = {
        icon = markdown_icon,
        color = markdown_color,
        name = 'Markdown',
      },

      -- WGSL shader
      wgsl = {
        icon = shader_icon_mixed,
        color = shader_color,
        name = 'Wgsl',
      },
      -- GLSL shader
      glsl = {
        icon = shader_icon_mixed,
        color = shader_color,
        name = 'Glsl',
      },
      -- GLSL Vertex shader
      vert = {
        icon = shader_icon_vert,
        color = shader_color,
        name = 'GlslVert',
      },
      -- GLSL Fragment shader
      frag = {
        icon = shader_icon_frag,
        color = shader_color,
        name = 'GlslFrag',
      },
      -- GLSL Compute shader
      comp = {
        icon = shader_icon_comp,
        color = shader_color,
        name = 'GlslComp',
      },
      -- GLSL Geometry shader
      geom = {
        icon = shader_icon_geom,
        color = shader_color,
        name = 'GlslGeom',
      },
      -- GLSL Tess. Control shader
      tesc = {
        icon = shader_icon_tesc,
        color = shader_color,
        name = 'GlslTesc',
      },
      -- GLSL Tess. Evaluation shader
      tese = {
        icon = shader_icon_tese,
        color = shader_color,
        name = 'GlslTese',
      },
    },
    default = true,
  })
end

function M.setup()
  vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
    group = vim.api.nvim_create_augroup('user_plugin_web_devicons', {}),
    callback = setup_icons,
  })
end

return M
