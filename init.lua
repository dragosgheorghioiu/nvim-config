-- ##################################DEFAULT SETTINGS##################################
vim.g.mapleader = " "

vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.conceallevel = 2
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = true
vim.g.loaded_netrwPlugin = 1

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.o.guicursor = "n-v-c:block"

-- ##################################DEFAULT_SETTINGS##################################

-- ##################################SETUP_PLUGIN_MANAGER#############################
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- load plugins
require("lazy").setup("plugins", {
	ui = {
		border = "rounded",
	},
})
-- ##################################SETUP_PLUGIN_MANAGER#############################

-- ##################################CORE_SETTINGS####################################
require("core")
-- ##################################CORE_SETTINGS####################################

-- ##################################FLOAT_TODO####################################
require("todo_buffer").setup({
   target_file = "~/notes/TODO.md"
})
-- ##################################FLOAT_TODO####################################

-- ##################################EDU_LSP#######################################
require("edulsp")
-- ##################################EDU_LSP#######################################
