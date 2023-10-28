return {
  "telescope.nvim",
  dependencies = {
    {

      "ThePrimeagen/git-worktree.nvim",
      event = "VeryLazy",
      config = function()
        require("lazyvim.util").on_load("telescope.nvim", function()
          require("telescope").load_extension("git_worktree")
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
}
