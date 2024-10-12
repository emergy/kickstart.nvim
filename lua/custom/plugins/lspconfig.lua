-- Получение архитектуры процессора
local arch = jit and jit.arch or vim.fn.system('uname -m'):gsub('%s+', '')

-- Плагины LSP
return {
  {
    -- Конфигурация `lazydev` для Lua LSP вашего Neovim-конфига, времени выполнения и плагинов
    -- используется для автодополнения, аннотаций и подсказок Neovim API
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Загрузка типов luvit, когда встречается слово `vim.uv`
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Основная конфигурация LSP
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Автоматическая установка LSP и связанных инструментов в stdpath для Neovim
      { 'williamboman/mason.nvim', config = true }, -- ВНИМАНИЕ: должен загружаться перед зависимыми плагинами

      {
        'williamboman/mason-lspconfig.nvim',
        config = function()
          -- Настройки для arm64
          if arch == 'arm64' then
            require('mason-lspconfig').setup {
              ensure_installed = { 'elixirls' },
              automatic_installation = true,
            }
          end
        end,
      },

      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Полезные обновления статуса для LSP.
      -- ВНИМАНИЕ: `opts = {}` эквивалентно вызову `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Позволяет использовать дополнительные возможности, предоставляемые nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Кратко: **Что такое LSP?**
      --
      -- LSP — это аббревиатура, которую вы, возможно, слышали, но не до конца понимаете её значение.
      --
      -- LSP расшифровывается как Language Server Protocol. Это протокол, который помогает редакторам
      -- и инструментам для работы с языками программирования взаимодействовать в стандартизированной форме.
      --
      -- В целом, существует "сервер", который представляет собой инструмент, построенный для понимания
      -- конкретного языка (например, `gopls`, `lua_ls`, `rust_analyzer` и т.д.). Эти языковые серверы
      -- (иногда их называют LSP-серверами, но это как говорить "банкомат-машина") являются
      -- самостоятельными процессами, которые взаимодействуют с "клиентом" — в нашем случае Neovim!
      --
      -- LSP предоставляет Neovim такие возможности, как:
      --  - Перейти к определению
      --  - Найти ссылки
      --  - Автодополнение
      --  - Поиск символов
      --  - и многое другое!
      --
      -- Следовательно, языковые серверы — это внешние инструменты, которые нужно устанавливать отдельно
      -- от Neovim. Именно здесь на помощь приходят `mason` и связанные плагины.
      --
      -- Если вы хотите узнать больше о lsp vs treesitter, вы можете посмотреть отлично
      -- и элегантно составленную справку: `:help lsp-vs-treesitter`

      -- Эта функция выполняется, когда LSP привязывается к конкретному буферу.
      -- Это происходит каждый раз, когда открывается новый файл, связанный с
      -- определенным LSP (например, открытие `main.rs` связано с `rust_analyzer`),
      -- и функция будет выполнена для настройки текущего буфера.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- ЗАМЕТКА: Помните, что Lua — это полноценный язык программирования, и, следовательно, возможно
          -- определять небольшие вспомогательные функции, чтобы не повторяться.
          --
          -- В этом случае мы создаем функцию, которая упрощает определение сопоставлений для LSP.
          -- Она автоматически задает режим, буфер и описание.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Переход к определению слова под курсором.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Поиск ссылок на слово под курсором.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Переход к реализации слова под курсором.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Переход к типу слова под курсором.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Поиск символов в текущем документе.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Поиск символов во всем проекте.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Переименование переменной под курсором.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Выполнение действия кода.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- Перейти к объявлению (не к определению).
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Подсветка ссылок на слово под курсором.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Создание сопоставления для переключения подсказок inlay.
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP серверы и клиенты могут обмениваться информацией о поддерживаемых возможностях.
      -- По умолчанию Neovim не поддерживает все возможности LSP.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Включение следующих языковых серверов.
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      -- Настройки для arm64
      if arch == 'arm64' then
        local lspconfig = require 'lspconfig'
        lspconfig.elixirls.setup {
          -- Укажите путь к вашему elixir-ls
          cmd = { '/data/data/com.termux/files/home/.config/nvim/elixir_ls/language_server.sh' },
          settings = {
            elixirLS = {
              dialyzerEnabled = false,
              fetchDeps = false,
              enableTestLenses = true,
            },
          },
        }
      else
        -- Установка серверов и инструментов.
        require('mason').setup()
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
          'stylua',
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }
        require('mason-lspconfig').setup {
          handlers = {
            function(server_name)
              local server = servers[server_name] or {}
              server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
              require('lspconfig')[server_name].setup(server)
            end,
          },
        }
      end
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
