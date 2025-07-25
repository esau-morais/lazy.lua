return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            env = {},
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        inline = {
          adapter = "anthropic",
          model = "claude-3-5-sonnet-latest",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
