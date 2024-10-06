vim.g.mapleader = " "

local vimset = vim.opt -- set options
vimset.tabstop = 2
vimset.softtabstop = 2
vimset.shiftwidth = 2
vimset.number = true
vimset.relativenumber = true
vimset.conceallevel = 2
vimset.clipboard = "unnamedplus"
vimset.termguicolors = true

-- clear highlights when pressing escape in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- create alias for :W to be :wa
vim.api.nvim_create_user_command("W", "wall", {})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup("plugins")

-- telescope keymaps
local teles = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", teles.find_files, {})
vim.keymap.set("n", "<leader>ps", teles.live_grep, {})
vim.keymap.set("n", "<leader>pe", teles.diagnostics, {})

local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "awesome" },
			},
		},
	},
})

-- clangd fix
require("lspconfig").clangd.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})

require("mason").setup({})
local mason_lspconfig = {
	ensure_installed = { "clangd", "pyright", "lua_ls", "gopls", "eslint", "html", "htmx" },
	handlers = {
		lsp_zero.default_setup,
	},
}
mason_lspconfig.handlers["rust_analyzer"] = function() end

require("mason-lspconfig").setup(mason_lspconfig)

vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>")

require("autocommand")
require("formatter-nvim")
require("oil").setup({})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ##############################SIGNATURE##############################
require("lsp_signature").setup({
	hint_prefix = "-> ",
	floating_window = false,
})
-- ##############################SIGNATURE##############################

-- ##############################HARPOON##############################
local harpoon = require("harpoon")
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<leader>hl", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<leader>h5", function()
	harpoon:list():select(5)
end)
-- ##############################HARPOON################################
