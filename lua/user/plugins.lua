local fn = vim.fn
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path, nil, nil)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
  print('Installing packer: Close and reopen Neovim...')
end

create_autocmd('BufWritePost', {
  group = create_augroup('user_plugin_packer_bootstrap', {}),
  pattern = '*/nvim/lua/user/plugins.lua',
  command = 'source <afile> | PackerSync',
})

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
})

packer = packer.startup(function(use, use_rocks)
  -- Packer manages packer
  use({ 'wbthomason/packer.nvim' })

  -- Lua libs
  use_rocks({ 'lyaml' })
  use_rocks({ 'lua-cjson' })
  use_rocks({ 'lpeg' })
  use({ 'nvim-lua/plenary.nvim' })

  -- Mappings
  use({ 'tpope/vim-repeat' })
  use({ 'inkarkat/vim-ReplaceWithRegister' })
  use({ 'folke/which-key.nvim' })

  -- Mini
  use({
    'echasnovski/mini.nvim',
    config = function()
      require('user.lazy-plugins.mini_misc')()
      require('user.lazy-plugins.mini_starter')()
      require('user.lazy-plugins.mini_bufremove')()
      require('user.lazy-plugins.mini_surround')()
      require('user.lazy-plugins.mini_jump')()
    end,
  })

  -- Theming
  use({ 'kyazdani42/nvim-web-devicons' })
  use({ 'nvim-lualine/lualine.nvim' })
  use({ 'marko-cerovac/material.nvim' })
  use({ 'lukas-reineke/indent-blankline.nvim' })
  use({ 'rcarriga/nvim-notify' })

  -- File/Project Management
  use({ 'tpope/vim-eunuch' })
  use({ 'editorconfig/editorconfig-vim' })
  use({ 'lewis6991/gitsigns.nvim' })
  use({ 'tpope/vim-fugitive' })
  use({
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeToggle',
      'NvimTreeRefresh',
      'NvimTreeFindFile',
      'NvimTreeFindFileToggle',
      'NvimTreeOpen',
      'NvimTreeClose',
      'NvimTreeRefresh',
      'NvimTreeResize',
      'NvimTreeCollapse',
      'NvimTreeCollapseKeepBuffers',
    },
    config = require('user.lazy-plugins.nvim-tree'),
  })

  -- FileType
  -- use({ 'sheerun/vim-polyglot' })
  -- use({ 'DingDean/wgsl.vim' })

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use({ 'JoosepAlviste/nvim-ts-context-commentstring' })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })

  -- Fuzzy finder
  use({ 'nvim-telescope/telescope.nvim' })
  use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
  use({ 'nvim-telescope/telescope-ui-select.nvim' })

  -- Editing
  use({ 'numToStr/Comment.nvim' })
  use({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = require('user.lazy-plugins.autopairs') })

  -- Diagnostics
  use({ 'folke/trouble.nvim' })

  -- Completion
  use({ 'rafamadriz/friendly-snippets' })
  use({ 'L3MON4D3/LuaSnip' })
  use({ 'hrsh7th/nvim-cmp' })
  use({ 'hrsh7th/cmp-nvim-lsp' })
  use({ 'hrsh7th/cmp-nvim-lsp-signature-help' })
  use({ 'hrsh7th/cmp-buffer' })
  use({ 'hrsh7th/cmp-path' })
  use({ 'uga-rosa/cmp-dictionary' })
  use({ 'saadparwaiz1/cmp_luasnip' })

  -- Language: Rust
  use({ 'simrat39/rust-tools.nvim' })
  use({
    'Saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = require('user.lazy-plugins.crates'),
  })

  -- LSP
  use({ 'neovim/nvim-lspconfig' })
  use({ 'williamboman/nvim-lsp-installer' })
  use({ 'jose-elias-alvarez/null-ls.nvim' })
  use({ 'kosayoda/nvim-lightbulb' })

  if packer_bootstrap then
    require('packer').sync()
  end
end)

return packer
