return {
  {
    'github/copilot.vim',
    config = function()
      -- Отключаем стандартный маппинг Tab для Copilot
      -- vim.g.copilot_no_tab_map = true

      -- Добавляем маппинг для стрелки вправо
      vim.keymap.set('i', '<M-L>', '<Plug>(copilot-accept-word)')

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'solarized',
        -- group = ...,
        callback = function()
          vim.api.nvim_set_hl(0, 'CopilotSuggestion', {
            fg = '#555555',
            ctermfg = 8,
            force = true,
          })
        end,
      })
    end,
  },
}
