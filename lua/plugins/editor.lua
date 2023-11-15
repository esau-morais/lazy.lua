return {
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
            local tl = require("telescope")
            tl.load_extension("git_worktree")
            tl.load_extension("harpoon")
          end)
        end,
        keys = {
          {
            "<leader>sr",
            "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            desc = "List worktrees",
          },
          {
            "<leader>sR",
            "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
            desc = "Create worktree",
          },
        },
      },
    },
  },
  { "tpope/vim-fugitive" },
  { "ThePrimeagen/harpoon" },
}
