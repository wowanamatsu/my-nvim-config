-- =========================================================================
--                              CORE.OPTIONS
-- Opções e configurações globais do Neovim (vim.opt)
-- =========================================================================

-- Atalho para vim.opt (Torna o código mais limpo)
local opt = vim.opt

-- Configurações Básicas
opt.encoding = 'utf-8'         -- Codificação de caracteres
opt.fileencoding = 'utf-8'     -- Codificação de arquivo

-- UI/Experiência do Usuário
opt.number = true              -- Linhas numeradas
opt.relativenumber = true      -- Números de linhas relativos (movimento)
opt.signcolumn = 'yes'         -- Sempre mostrar coluna de sinais
opt.cursorline = true          -- Linha do cursor destacada
opt.termguicolors = true       -- Habilita cores verdadeiras no terminal
opt.hlsearch = true            -- Destacar resultados da busca
opt.mouse = 'a'                -- Habilita o uso do mouse

-- Indentação e Tabs
opt.tabstop = 4                -- Quantidade de espaços que um <Tab> ocupa
opt.shiftwidth = 4             -- Quantidade de espaços para auto-indentação
opt.expandtab = true           -- Usa espaços em vez de tabuladores
opt.autoindent = true          -- Auto-indentação ao criar nova linha
opt.smartindent = true         -- Indentação inteligente

-- Desempenho
opt.swapfile = false           -- Não criar arquivo de swap (geralmente mais rápido)
opt.backup = false             -- Não criar arquivo de backup
opt.writebackup = false        -- Não criar writebackup
opt.updatetime = 300           -- Tempo para gravar o swapfile (usado por plugins como LSP)
