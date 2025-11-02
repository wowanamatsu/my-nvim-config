require('lualine').setup({
    options = {
        theme = 'tokyonight',
        icons_enabled = true,
        component_separators = { left = '', right = ''}, -- Separadores elegantes (pode ser '' para nenhum)
        section_separators = { left = '', right = ''},   -- Separadores de seção (pode ser '' para nenhum)
    },
    sections = {
        -- Esquerda: Mais Visível
        lualine_a = {'mode'},                                       -- Modo do Vim
        lualine_b = {'branch', 'diff'},                             -- Branch e Diff do Git
        lualine_c = {{'filename', path = 1}},                       -- Nome do arquivo
        
        -- Direita: Informações Secundárias
        lualine_x = {'diagnostics', 'filetype'},                    -- Diagnósticos LSP e Filetype
        lualine_y = {'progress'},                                   -- Progresso no arquivo
        lualine_z = {'location'},                                   -- Localização (Linha:Coluna)
    },
    -- Para mostrar os diagnósticos (erros/warnings) do LSP
    -- Necessita do `nvim-web-devicons`
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
})