return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").load({ paths = "../../snippets/" })
      -- in case something goes wrong
      -- require("luasnip").log.set_loglevel("debug")
    end,
  },
}
