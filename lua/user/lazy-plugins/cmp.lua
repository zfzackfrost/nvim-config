return function()
  vim.opt.completeopt = 'menuone,noselect'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = 'ﴯ',
    Interface = '',
    Module = '',
    Property = 'ﰠ',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  }

  local formatter = function(entry, vim_item)
    vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
    vim_item.menu = ({
      nvim_lsp = '[LSP]',
      luasnip = '[Snips]',
      buffer = '[Buff]',
      path = '[Path]',
      crates = '[Crate]',
      dictionary = '[Dict]',
    })[entry.source.name]
    return vim_item
  end

  local window_config = cmp.config.window.bordered({
    winhighlight = 'CursorLine:Visual,Search:None',
  })

  cmp.setup({
    formatting = {
      format = formatter,
    },
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' },
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = window_config,
      documentation = window_config,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-2),
      ['<C-f>'] = cmp.mapping.scroll_docs(2),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
    }, {
      { name = 'path' },
      { name = 'buffer' },
    }),
  })

  cmp.setup.filetype({ 'markdown', 'help' }, {
    sources = cmp.config.sources({
      { name = 'luasnip' },
    }, {
      { name = 'path' },
      { name = 'buffer' },
    }, {
      { name = 'dictionary', keyword_length = 2 },
    }),
  })

  cmp.setup.filetype({ 'toml' }, {
    sources = cmp.config.sources({
      { name = 'crates' },
    }, {
      { name = 'path' },
      { name = 'buffer' },
    }),
  })
end
