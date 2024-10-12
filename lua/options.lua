-- [[ Настройка параметров ]]
-- См. `:help vim.opt`
-- ПРИМЕЧАНИЕ: Вы можете изменять эти параметры по своему усмотрению!
--  Для дополнительных параметров см. `:help option-list`

-- Включаем номера строк по умолчанию
vim.opt.number = true
-- Вы также можете включить относительные номера строк для удобного перемещения.
--  Попробуйте, чтобы понять, нравится ли вам это!
-- vim.opt.relativenumber = true

-- Включаем режим работы с мышью, это может быть полезно для изменения размеров сплитов, например!
vim.opt.mouse = 'a'

-- Не отображаем режим, так как он уже показан в строке состояния
vim.opt.showmode = false

-- Синхронизируем буфер обмена между ОС и Neovim.
--  Настройка применяется после события `UiEnter`, чтобы не увеличивать время загрузки.
--  Уберите эту опцию, если хотите, чтобы буфер обмена ОС оставался независимым.
--  См. `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Включаем перенос с отступом
vim.opt.breakindent = true

-- Сохраняем историю отмен
vim.opt.undofile = true

-- Поиск без учета регистра, ЕСЛИ не используется \C или в поисковом запросе нет заглавных букв
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Включаем колонку для знаков (signcolumn) по умолчанию
vim.opt.signcolumn = 'yes'

-- Уменьшаем время обновления
vim.opt.updatetime = 250

-- Уменьшаем время ожидания для привязанных последовательностей клавиш
-- Отображает всплывающее окно which-key быстрее
vim.opt.timeoutlen = 300

-- Настройка открытия новых сплитов
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Настройка отображения некоторых символов пробелов в редакторе.
--  См. `:help 'list'`
--  и `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Предпросмотр замен в реальном времени при вводе!
vim.opt.inccommand = 'split'

-- Отображение строки, на которой находится курсор
vim.opt.cursorline = true

-- Минимальное количество строк на экране, которые нужно сохранять выше и ниже курсора
vim.opt.scrolloff = 10

-- Удобная справка справа (:help)
vim.cmd [[
  autocmd FileType help wincmd L
  autocmd FileType help wincmd 82|
]]

-- Сохранение последней позиции курсора при закрытии файла
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    local line = vim.fn.line
    local last_position = line '\'"'
    if last_position > 0 and last_position <= line '$' then
      vim.api.nvim_win_set_cursor(0, { last_position, 0 })
    end
  end,
})

-- vim: ts=2 sts=2 sw=2 et
