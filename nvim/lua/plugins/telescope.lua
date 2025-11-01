-- ~/.config/nvim/lua/plugins/telescope.lua

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  lazy = false, -- Garante carregamento imediato
  cmd = 'Telescope', 

  dependencies = {
    'nvim-lua/plenary.nvim', 
    'nvim-tree/nvim-web-devicons', 
  },

  -- Remova o campo 'keys' inteiramente se ele estiver aí.

  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin') -- Módulo que contém as funções (find_files)
    
    -- Configuração do Telescope (Seu setup)
    telescope.setup({
      defaults = {
        theme = 'ivy',
      },
    })
  end,
}