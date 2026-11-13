return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  config = function()
    local api_key = os.getenv("DEEPSEEK_API_KEY")
    if not api_key then
      vim.notify(
        "DEEPSEEK_API_KEY не задан! Проверьте переменные окружения.",
        vim.log.levels.ERROR
      )
    end

    require("codecompanion").setup({
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = api_key,
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
      },
    })
  end,
}
