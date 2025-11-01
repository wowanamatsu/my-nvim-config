-- =========================================================================
--                                INIT.LUA
-- Ponto de entrada da configuração do Neovim.
-- Carrega os módulos de configuração na ordem.
-- =========================================================================

-- Carrega as opções e configurações básicas do editor
require('core.options')

-- Carrega o gerenciador de plugins e instala/configura os plugins
require('plugins.init')

-- Carrega os mapeamentos de teclas globais
-- (Deve ser carregado APÓS os plugins, pois alguns keymaps podem depender deles)
require('core.keymaps')

-- Você pode adicionar um require('core.autocmds') se for usar grupos grandes
-- de Auto Comandos personalizados.
