local find_config = function(bufnr, config_files)
  return vim.fs.find(config_files, {
    upward = true,
    stop = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })[1]
end

local biome_or_prettier = function(bufnr)
  local has_biome_config = find_config(bufnr, { "biome.json", "biome.jsonc" })

  if has_biome_config then
    return { "biome", stop_after_first = true }
  end

  local has_prettier_config = find_config(bufnr, {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.json5",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.toml",
    "prettier.config.js",
    "prettier.config.cjs",
  })

  if has_prettier_config then
    return { "prettier", stop_after_first = true }
  end

  -- Default to Prettier if no config is found
  return { "prettier", stop_after_first = true }
end

local format_file = function(bufnr)
  local file = vim.api.nvim_buf_get_name(bufnr)
  local formatter = biome_or_prettier(bufnr)

  if formatter[1] == "biome" then
    -- Run Biome
    local result = vim.fn.system("biome check --write " .. vim.fn.shellescape(file))
    if vim.v.shell_error == 0 then
      vim.cmd("edit!")
    else
      vim.api.nvim_err_writeln("Biome error: " .. result)
    end
  end
  -- Add Prettier logic here if needed
end

local filetypes_with_dynamic_formatter = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "vue",
  "css",
  "scss",
  "less",
  "html",
  "json",
  "jsonc",
  "yaml",
  "markdown",
  "markdown.mdx",
  "graphql",
  "handlebars",
}

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
    opts = function(_, opts)
      opts.formatters_by_ft = (function()
        local result = {}
        for _, ft in ipairs(filetypes_with_dynamic_formatter) do
          result[ft] = biome_or_prettier
        end
        return result
      end)()

      -- Add Biome formatter
      -- opts.formatters = opts.formatters or {}
      opts.formatters.biome = {
        command = "biome",
        args = { "check", "--write", "$FILENAME" }, --  ← this was the magic that fixed organizing imports
        stdin = false,
      }

      return opts
    end,
  },
  {
    "stevearc/conform.nvim",
    ---@class ConformOpts
    opts = {
      formatters_by_ft = {
        javascript = biome_lsp_or_prettier,
        typescript = biome_lsp_or_prettier,
        javascriptreact = biome_lsp_or_prettier,
        typescriptreact = biome_lsp_or_prettier,
        json = { "biome" },
        jsonc = { "biome" },
      },
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
    "nvim-mini/mini.diff",
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
