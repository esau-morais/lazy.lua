vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

--vim.cmd()
vim.opt.clipboard = "unnamedplus"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- INFO: see https://github.com/epwalsh/obsidian.nvim/issues/286
vim.opt.conceallevel = 2

-- Enable this option to avoid conflicts with Prettier.
vim.g.lazyvim_prettier_needs_config = true
