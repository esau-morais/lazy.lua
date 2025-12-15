return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classFunctions = {
                "cva",
                "clsx",
                "cn",
                "className",
                "class",
              },
            },
          },
        },
      },
    },
  },
}
