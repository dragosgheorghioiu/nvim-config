vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

local vimset = vim.opt -- set options
vimset.tabstop = 2
vimset.softtabstop = 2
vimset.shiftwidth = 2
vimset.number = true
vimset.relativenumber = true

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

local cmp = require("cmp")

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
})

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "pyright" },
	handlers = {
		lsp_zero.default_setup,
	},
})

vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>")

require("autocommand")
require("nvim-autopairs").setup({})
require("formatter-nvim")
