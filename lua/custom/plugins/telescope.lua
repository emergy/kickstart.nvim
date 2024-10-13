-- ПРИМЕЧАНИЕ: Плагины могут указывать зависимости.
--
-- Зависимости — это полноценные спецификации плагинов - всё,
-- что вы делаете для плагина на верхнем уровне, можно сделать и для зависимости.
--
-- Используйте ключ `dependencies`, чтобы указать зависимости конкретного плагина.

local actions = require 'telescope.actions'

return {
  { -- Fuzzy Finder (поиск файлов, lsp, и т.д.)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- Если возникают ошибки, см. README файла telescope-fzf-native для инструкций по установке
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` используется для выполнения команды, когда плагин установлен/обновлен.
        -- Эта команда выполняется только в этот момент, а не при каждом запуске Neovim.
        build = 'make',

        -- `cond` — это условие, используемое для определения, должен ли этот плагин
        -- быть установлен и загружен.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Полезно для красивых иконок, но требует шрифта Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope — это инструмент для поиска с поддержкой множества возможностей,
      -- он умеет искать не только файлы! Он может искать
      -- различные аспекты Neovim, рабочую область, LSP и многое другое!
      --
      -- Самый простой способ начать использовать Telescope — это выполнить команду:
      --  :Telescope help_tags
      --
      -- После выполнения этой команды откроется окно, в котором можно вводить
      -- запросы в строке ввода. Вы увидите список доступных опций `help_tags`
      -- и соответствующий предпросмотр справки.
      --
      -- Две важные комбинации клавиш при работе с Telescope:
      --  - В режиме вставки: <c-/>
      --  - В нормальном режиме: ?
      --
      -- Это откроет окно с отображением всех комбинаций клавиш для текущего
      -- выбора в Telescope. Это очень полезно для изучения возможностей Telescope
      -- и того, как ими пользоваться!

      -- [[ Настройка Telescope ]]
      -- См. `:help telescope` и `:help telescope.setup()`
      require('telescope').setup {
        -- Здесь можно указать настройки по умолчанию, такие как привязки клавиш и другие обновления
        -- Вся необходимая информация находится в `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            i = { ['<CR>'] = actions.select_tab }, -- Открывать в новом табе в режиме вставки
            n = { ['<CR>'] = actions.select_tab }, -- Открывать в новом табе в нормальном режиме
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Включение расширений Telescope, если они установлены
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- См. `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch текущего [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch по [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch последние файлы ("." для повтора)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Пример немного более сложного переопределения поведения по умолчанию и темы
      vim.keymap.set('n', '<leader>/', function()
        -- Дополнительные параметры могут быть переданы в Telescope для изменения темы, расположения и т.д.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Нечеткий поиск в текущем буфере' })

      -- Также можно передать дополнительные параметры конфигурации.
      -- См. `:help telescope.builtin.live_grep()` для информации о конкретных ключах
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep в открытых файлах',
        }
      end, { desc = '[S]earch [/] в открытых файлах' })

      -- Ярлык для поиска файлов конфигурации Neovim
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim файлы' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
