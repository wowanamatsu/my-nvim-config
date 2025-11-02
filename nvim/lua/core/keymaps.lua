-- =========================================================================
--                              CORE.KEYMAPS
-- Mapeamentos de teclas globais (atalhos)
-- =========================================================================

-- Define a tecla líder (Leader Key)
-- A barra de espaço é a escolha mais comum hoje em dia:
if vim.g.mapleader == nil then
  vim.g.mapleader = ' ' 
end
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps do Telescope (Mapeamento direto para comandos)
local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = '[F]ind [G]rep (texto)' })
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>sd', '<cmd>Telescope diagnostics<cr>', { desc = '[S]earch [D]iagnostics' })

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

-- Mover entre tabs do editor
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Mover para a janela à esquerda' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Mover para a janela à direita' })


