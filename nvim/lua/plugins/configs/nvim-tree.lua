-- =========================================================================
--                      PLUGINS.CONFIGS.NVIM-TREE
-- Configuração do plugin de exploração de arquivos (File Explorer)
-- =========================================================================

local M = {}

M.setup = function()
  require('nvim-tree').setup({
    sort_by = 'case_sensitive',
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  })
end

return M
