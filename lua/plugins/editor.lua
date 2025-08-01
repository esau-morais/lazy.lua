return {
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name)
          return vim.startswith(name, ".")
        end,
        is_always_hidden = function(name)
          local never_show = { ".git", "node_modules" }

          for _, val in ipairs(never_show) do
            if name == val then
              return true
            end

            return false
          end
        end,
      },
    },
    keys = {
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "oil" then
            require("oil").close()
          else
            require("oil").open()
          end
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            "node_modules",
            ".git",
          },
        },
      },
      window = {
        width = 30,
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "󰁕", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      {

        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        config = function()
          require("lazyvim.util").on_load("telescope.nvim", function()
            require("telescope").load_extension("git_worktree")
            require("telescope").load_extension("harpoon")
          end)
        end,
        keys = {
          {
            "<leader>m",
            "<CMD>Telescope harpoon marks<CR>",
            desc = "List harpoon marks",
          },
          {
            "<leader>lw",
            "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            desc = "List worktrees",
          },
          {
            "<leader>cw",
            "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
            desc = "Create worktree",
          },
        },
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = {
          "./packages/hub-template/*",
        },
      },
    },
  },
  { "tpope/vim-fugitive" },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = function()
      local keys = {
        {
          "<leader>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>h",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end
      return keys
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
  {
    "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
    keys = {
      {
        "<leader>ut",
        "<cmd>UndotreeToggle<CR>",
        desc = "Toggle Undotree",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["html"] = { "prettier" },
      },
    },
  },
  {
    "mistricky/codesnap.nvim",
    build = "make",
    opts = {
      border = "rounded",
      has_breadcrumbs = true,
      bg_theme = "summer",
      watermark = "",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false },
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/notes/",
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
