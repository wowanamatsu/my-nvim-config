-- =========================================================================
--                        PLUGINS.CONFIGS.LSP
-- Configuração do nvim-lspconfig e LuaLS
-- =========================================================================

-- Requer os módulos necessários
local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Função para configurar os keymaps do LSP quando ele se anexa a um buffer
local on_attach = function(client, bufnr)
  -- Desabilita formatação automática se você for usar um plugin dedicado (ex: none-ls)
  -- client.server_capabilities.documentFormattingProvider = false

  -- Keymaps específicos do LSP (apenas no buffer atual)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }

  -- Definir os Keymaps LSP

  -- K: Documentação Flutuante (Hover)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- gd: Ir para Definição
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)

  -- gD: Ir para Declaração
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)

  -- gi: Ir para Implementação
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  -- gr: Encontrar Referências
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- <leader>rn: Renomear (Rename)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  -- <leader>ca: Ação de Código (Code Action)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- Configuração específica do LUALS
local lua_ls_settings = {
  settings = {
    Lua = {
      runtime = {
        -- Informa a versão do Lua (LuaJIT é o padrão do Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Faz o servidor reconhecer o global 'vim' e a API do Neovim (neodev.nvim ajuda MUITO aqui)
        globals = { 'vim' },
      },
      workspace = {
        -- Adiciona o runtime do Neovim à biblioteca para contexto
        library = {},--vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Configuração do Mason Lspconfig
-- Ele vai instalar e configurar automaticamente os servidores na lista 'ensure_installed'
mason_lspconfig.setup({
  -- Lista de LSPs para instalar automaticamente (você pode adicionar mais aqui)
  ensure_installed = {
    'lua_ls', -- O servidor de linguagem Lua
    'pyright',
    'ts_ls',
    'clangd',
    'intelephense',
    'omnisharp',
    'gopls',
    'angularls',
    -- 'jsonls',
    -- 'html',
    -- 'cssls',
  },

  -- Função de manipulação para configurar os servidores
  handlers = {
    -- Configuração padrão para todos os LSPs que o Mason sabe como configurar
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
    end,

    -- SOBRESCREVE a configuração padrão apenas para o lua_ls (inclui as configurações do Neodev/LSP)
    ['lua_ls'] = function()
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        -- Combina as configurações padrões com as personalizadas
        settings = lua_ls_settings.settings,
      })
    end,

    ['pyright'] = function()
      lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        -- Configuração adicional para Pyright (opcional, mas recomendado)
        settings = {
          pyright = {
            -- Garante que ele use o ambiente Python correto
            venvPath = vim.fn.expand('~/.local/share/virtualenvs'),
            analysis = {
              typeCheckingMode = 'basic', -- 'off', 'basic', ou 'strict'
              diagnosticMode = 'workspace',
              autoSearchPaths = true,
              use="pyright"
            }
          }
        }
      })
    end,

    ['tsserver'] = function() -- Nota: Embora "ts_ls" seja o mais novo, "tsserver" ainda é muito comum e funcional.
      require('lspconfig').tsserver.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        -- Configuração adicional para Tsserver (opcional)
        settings = {
          typescript = {
            inlayHints = {
              -- Habilita dicas de tipos inline no código
              parameterNames = 'all',
              parameterTypes = true,
              variableTypes = true,
              -- ...
            }
          },
          javascript = {
            inlayHints = {
              parameterNames = 'all',
              parameterTypes = true,
              variableTypes = true,
              -- ...
            }
          }
        }
      })
    end,

    ['clangd'] = function()
      require('lspconfig').clangd.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        cmd = {
          "clangd",
          "--background-index", -- Indexação em segundo plano
          "--clang-tidy",       -- Habilita o Clang-Tidy (linter)
          "--header-insertion-decorators", -- Adiciona um cabeçalho para inserções
        },
        init_options = {
          fallbackFlags = { "-std=c++17" }, -- Flag padrão para projetos simples
        },
        -- Opcional: Adicionar um comando útil para C/C++
        keys = {
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        }
      })
    end,

    ['intelephense'] = function()
      require('lspconfig').intelephense.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          -- Configuração específica para Intelephense
          intelephense = {
            environment = {
              -- Adiciona caminhos de inclusão globais (como para o Laravel IDE Helper)
              includePaths = {
                "vendor/laravel/framework/src",
                "vendor/barryvdh/laravel-ide-helper",
              },
              -- Stubs para lidar com métodos que não estão no código, mas são injetados
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                -- ... adicione outros stubs se necessário (ex: laravel, phpunit, etc.)
              },
            },
            telemetry = {
              enabled = false, -- Desativa o envio de dados
            },
            completion = {
              fullyQualifyGlobalConstantsAndFunctions = false,
            }
          }
        }
      })
    end,

    ['omnisharp'] = function()
      -- O Mason instala o executável do OmniSharp (um .dll) em um subdiretório
      local omnisharp_bin = vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/OmniSharp.dll'

      if vim.fn.filereadable(omnisharp_bin) then
        require('lspconfig').omnisharp.setup({
          on_attach = on_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities(),
          cmd = { 
            -- O comando correto é 'dotnet' seguido do caminho para o DLL do OmniSharp
            'dotnet', 
            omnisharp_bin,
            '--languageserver', -- Necessário para usar o OmniSharp como LSP
            '--hostPID', tostring(vim.fn.getpid()),
          },
          settings = {
            -- Habilita o suporte a Roslyn Analyzers
            EnableRoslynAnalyzers = true, 
            -- Habilita a leitura do .editorconfig para formatação
            FormattingOptions = {
              EnableEditorConfigSupport = true,
            },
            -- Garante que ele inclua versões de pré-lançamento do SDK do .NET
            Sdk = {
                IncludePrereleases = true,
            },
          },
          telemetry = {
              enabled = false, -- Desativa o envio de dados
          },
          -- O OmniSharp funciona melhor quando iniciado a partir da raiz do projeto (.sln ou .csproj)
          root_dir = require('lspconfig.util').root_pattern('*.sln', '*.csproj', '.git', 'package.json'),
        })
      else
         vim.notify("OmniSharp.dll não encontrado. Verifique a instalação do dotnet SDK e do OmniSharp via :Mason.", vim.log.levels.WARN)
      end
    end,

    ['gopls'] = function()
        require('lspconfig').gopls.setup({
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
                gopls = {
                    -- Habilita gofmt e goimports-reviser (formatters)
                    gofumpt = true, 
                    -- Habilita verificações de código estáticas (staticcheck, unusedparams)
                    staticcheck = true,
                    analyses = {
                        unusedparams = true,
                    },
                    -- O goimports-reviser pode ser útil para organizar imports
                    codelenses = {
                        go_mod_tidy = true,
                        generate = true,
                        test = true,
                    },
                },
            },
            telemetry = {
              enabled = false, -- Desativa o envio de dados
            },
            -- A maioria dos LSPs de Go e .NET precisa da raiz do módulo/projeto
            root_dir = require('lspconfig.util').root_pattern('go.mod', '.git'),
        })
    end,

    ['angularls'] = function()
        local lspconfig = require('lspconfig')
        local util = require('lspconfig.util')

        -- Define o padrão de busca da raiz do projeto para Angular
        local angular_root_pattern = util.root_pattern(
            'angular.json',
            'tsconfig.json',
            'package.json'
        )
        
        lspconfig.angularls.setup({
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            root_dir = angular_root_pattern,
            -- Configurações adicionais se necessário, como strictTemplates
            settings = {
                angular = {
                    -- Tenta usar o TypeScript do workspace em vez do global
                    disableAutomaticWorkspacePush = false, 
                },
            },
            telemetry = {
              enable = false,
            },
        })
    end,
  },
})
