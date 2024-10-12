-- [[ Настройка и установка плагинов ]]
--
--  Чтобы проверить текущий статус ваших плагинов, выполните
--    :Lazy
--
--  Вы можете нажать `?` в этом меню для справки. Используйте `:q` для закрытия окна
--
--  Для обновления плагинов выполните
--    :Lazy update
--
-- ПРИМЕЧАНИЕ: Здесь вы устанавливаете свои плагины.
require('lazy').setup({
  -- ПРИМЕЧАНИЕ: Плагины можно добавить с помощью ссылки (или для репозитория на github: ссылка в формате 'owner/repo').
  'tpope/vim-sleuth', -- Автоматическое определение tabstop и shiftwidth
  -- 'lukas-reineke/indent-blankline.nvim',

  -- ПРИМЕЧАНИЕ: Плагины также можно добавлять с помощью таблицы,
  -- где первый аргумент — это ссылка, а следующие ключи
  -- могут быть использованы для настройки поведения плагина/загрузки и т. д.
  --
  -- Используйте `opts = {}`, чтобы принудительно загрузить плагин.
  --

  -- модульный подход: использование `require 'path/name'`
  -- подключает определение плагина из файла lua/path/name.lua

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  -- require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  -- Следующие два комментария работают только если вы загрузили репозиторий kickstart, а не просто скопировали
  -- init.lua. Если вам нужны эти файлы, они находятся в репозитории, так что вы можете их скачать и
  -- разместить в нужных местах.

  -- ПРИМЕЧАНИЕ: Следующий шаг в вашем путешествии с Neovim: добавьте/настройте дополнительные плагины для Kickstart
  --
  --  Вот некоторые примеры плагинов, которые я включил в репозиторий Kickstart.
  --  Раскомментируйте любую из строк ниже, чтобы активировать их (вам потребуется перезапустить nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

  -- ПРИМЕЧАНИЕ: Импорт ниже может автоматически добавить ваши собственные плагины, настройки и т. д. из `lua/custom/plugins/*.lua`
  --    Это самый простой способ модульной настройки конфигурации.
  --
  --  Раскомментируйте следующую строку и добавьте ваши плагины в `lua/custom/plugins/*.lua`, чтобы начать.
  --    Для дополнительной информации см. `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- Если вы используете шрифт Nerd Font: установите icons в пустую таблицу, чтобы использовать
    -- значки Nerd Font по умолчанию, определённые в lazy.nvim, иначе определите таблицу с юникод-значками
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
