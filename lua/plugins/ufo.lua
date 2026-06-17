return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    -- Загружаем при старте или открытии файла, чтобы опции применились
    event = "BufReadPost",
    init = function()
      -- Обязательные системные настройки Neovim для работы UFO
      vim.o.foldcolumn = "1" -- Показывает колонку фолдинга слева (можно "0", если не нужна)
      vim.o.foldlevel = 99 -- Высокий уровень, чтобы при открытии файла код не был свернут
      vim.o.foldlevelstart = 99 -- Начинать с развернутых блоков
      vim.o.foldenable = true -- Включить фолдинг
    end,
    opts = {
      -- Используем связку Treesitter + Indent как фолбэк провайдер
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)

      -- Горячие клавиши UFO для сворачивания/разворачивания ВСЕГО файла
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Открыть все свёртки" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Свернуть все свёртки" })
    end,
  },
}
