local logo = [[
 __        __   _                              _____                 
 \ \      / /__| | ___ ___  _ __ ___   ___    | ____|___  __ _ _   _ 
  \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \   |  _| / __|/ _` | | | |
   \ V  V /  __/ | (_| (_) | | | | | |  __/_  | |___\__ \ (_| | |_| |
    \_/\_/ \___|_|\___\___/|_| |_| |_|\___( ) |_____|___/\__,_|\__,_|
                                          |/                         
]]
logo = string.rep("\n", 8) .. logo .. "\n\n"

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "",
        section_separators = "",
        sections = {
          lualine_z = {},
        },
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    opts = {
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Telescope oldfiles",
            desc = " Recent files",
            icon = " ",
            key = "r",
          },
          {
            action = "Telescope find_files",
            desc = " Find file",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New file",
            icon = " ",
            key = "n",
          },
          {
            action = "Telescope live_grep",
            desc = " Find text",
            icon = " ",
            key = "g",
          },
          {
            action = 'lua require("persistence").load()',
            desc = " Restore Session",
            icon = " ",
            key = "s",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      enabled = false,
    },
  },
}
