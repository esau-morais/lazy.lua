local servers = { "eslint", "prettier", "lua_ls", "rust_analyzer", "tailwind", "tsserver" }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    },
  },
  { "williamboman/mason-lspconfig.nvim", opts = { ensure_install = servers } },
}
