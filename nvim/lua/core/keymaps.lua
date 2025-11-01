-- =========================================================================
--                              CORE.KEYMAPS
-- Mapeamentos de teclas globais (atalhos)
-- =========================================================================

-- Define a tecla líder (Leader Key)
-- A barra de espaço é a escolha mais comum hoje em dia:
vim.g.mapleader = ' '

-- Atalho para vim.keymap.set (Torna o código mais limpo)
local map = vim.keymap.set

-- Configurações de Mapeamento (Modo Normal)
map('n', '<leader>w', ':w<CR>', { desc = 'Salvar Arquivo' })
map('n', '<leader>q', ':q<CR>', { desc = 'Sair do Neovim' })
map('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Alternar Navegador de Arquivos' })

-- Navegação entre buffers
map('n', '<leader>bn', ':bnext<CR>', { desc = 'Próximo Buffer' })
map('n', '<leader>bp', ':bprevious<CR>', { desc = 'Buffer Anterior' })
map('n', '<leader>bd', ':bd<CR>', { desc = 'Fechar Buffer' })

-- Mover Linhas (Modo Normal e Visual)
map('n', '<A-Down>', ':m .+1<CR>==', { desc = 'Mover linha para baixo' })
map('n', '<A-Up>', ':m .-2<CR>==', { desc = 'Mover linha para cima' })
map('v', '<A-Down>', ":m '>+1<CR>gv=gv", { desc = 'Mover seleção para baixo' })
map('v', '<A-Up>', ":m '<-2<CR>gv=gv", { desc = 'Mover seleção para cima' })
