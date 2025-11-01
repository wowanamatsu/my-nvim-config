-- =========================================================================
--                          PLUGINS.CONFIGS.CMP
-- Configuração do nvim-cmp (Motor de Autocompletar)
-- =========================================================================

-- Atalhos para os módulos
local cmp = require('cmp')
local luasnip = require('luasnip')

-- Define as fontes de autocompletar a serem usadas (ordem de prioridade)
local sources = {
  { name = 'nvim_lsp' },  -- Fontes do Language Server Protocol (O mais importante)
  { name = 'luasnip' },   -- Fontes do Snippet Engine
  { name = 'buffer' },    -- Palavras do buffer atual
  { name = 'path' },      -- Nomes de arquivos/diretórios
}

-- Configuração principal do nvim-cmp
cmp.setup({
  snippet = {
    -- Função para expandir o snippet
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    -- ENTER: Seleciona e expande o item (se for um snippet)
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    -- TAB/SHIFT-TAB: Navegar na lista
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- Se não estiver no menu e houver um snippet, expande
      elseif luasnip.expandable() or luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback() -- Pula para a próxima tab-stop
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      -- Se estiver em um snippet, volta para a tab-stop anterior
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- CTRL-SPACE: Força a exibição do menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources(sources),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    native_menu = false,
    ghost_text = true, -- Exibe sugestão flutuante (como no VS Code)
  },
})
