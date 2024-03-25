vim.g.mapleader = " "

local vimset = vim.opt -- set options
vimset.tabstop = 2
vimset.softtabstop = 2
vimset.shiftwidth = 2
vimset.number = true
vimset.relativenumber = true
vimset.conceallevel = 2
vimset.clipboard = "unnamedplus"

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
				globals = { "vim" },
			},
		},
	},
})

-- clangd fix
local cmp_nvim_lsp = require("cmp_nvim_lsp")
require("lspconfig").clangd.setup({
	capabilities = cmp_nvim_lsp.default_capabilities(),
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "pyright", "lua_ls" },
	handlers = {
		lsp_zero.default_setup,
	},
})

vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>")

require("autocommand")
require("nvim-autopairs").setup({})
require("formatter-nvim")
require("oil").setup({})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ##############################SIGNATURE##############################
local lsp_signature_config = {
	hint_prefix = "-> ",
}
require("lsp_signature").setup(lsp_signature_config)
vim.keymap.set({ "i" }, "<C-k>", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

-- ##############################SIGNATURE##############################

-- ##############################Harpoon##############################
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
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
-- ##############################Harpoon################################
-- ##############################Obsidian###############################
local obsidian = require("obsidian")
local config = {
	workspaces = {
		{
			name = "Dregos",
			path = "~/Dregos",
		},
	},
}
obsidian.setup(config)
-- ##############################Obsidian###############################
