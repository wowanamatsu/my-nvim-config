-- =========================================================================
--                              PLUGINS.INIT
-- Configuração do Lazy.nvim (Plugin Manager) e Lista de Plugins
-- =========================================================================

-- ... (código de bootstrap do lazy.nvim permanece o mesmo) ...
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lista de Plugins
local plugins = {
  -- Plugin Manager
  'folke/lazy.nvim',

  -- 1. Plugin de Navegação/Filesystem
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    config = function()
      require('plugins.configs.nvim-tree').setup()
    end,
  },

  -- 2. Cores/Temas
  { 'folke/tokyonight.nvim', name = 'tokyonight', priority = 1000 },

  -- 3. Melhoria de Sintaxe/Parsing
  'nvim-treesitter/nvim-treesitter',

  -- ===================================
  --        4. CONFIGURAÇÃO LSP/CMP
  -- ===================================

  -- Gerenciadores de Servidores LSP, DAP, Formatters
  {
    'williamboman/mason.nvim', -- 👈 AGORA É UMA TABELA
    cmd = 'Mason',             -- Força o carregamento do plugin quando o comando é usado
    config = function()
      require('mason').setup() -- Inicializa o Mason, registrando os comandos como :Mason
    end,
  },
  'williamboman/mason-lspconfig.nvim',

  -- O Cliente LSP principal do Neovim
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp', -- Fontes para o LSP
    },
    config = function()
      -- Carrega o módulo de configuração LSP
      require('plugins.configs.lsp')
    end,
  },

  -- Essencial para o LuaLS reconhecer a API do Neovim
  { 'folke/neodev.nvim', opts = {} },

  -- --- Motor de Autocompletar (nvim-cmp) ---
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Fontes de Completar (Completition Sources)
      'hrsh7th/cmp-buffer',   -- Fontes do buffer atual
      'hrsh7th/cmp-path',     -- Fontes de caminhos de arquivo
      'hrsh7th/cmp-nvim-lsp', -- JÁ ADICIONAMOS (para completação via LSP)
      'L3MON4D3/LuaSnip',     -- Engine de Snippets
      'saadparwaiz1/cmp_luasnip', -- Integração cmp e LuaSnip
    },
    config = function()
      -- Carrega o módulo de configuração do CMP
      require('plugins.configs.cmp')
    end,
  },
  
  require('plugins.telescope'),
}

-- Configuração e inicialização do Lazy.nvim
require('lazy').setup(plugins, {
  -- Opções adicionais aqui
})

-- Define o tema APÓS a inicialização do lazy.nvim
vim.cmd('colorscheme tokyonight')
