return {
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup {
        current_line_blame = true, -- включает blame на текущую строку
        current_line_blame_opts = {
          delay = 1000, -- задержка перед показом blame (в миллисекундах)
          virt_text = true,
        },
      }
    end,
    event = { 'BufReadPre', 'BufNewFile' }, -- ленивый запуск при открытии файла
  },
}
