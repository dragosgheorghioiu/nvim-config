vim.g.mapleader = " "

vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.number = true
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.scrolloff = 10
vim.o.guicursor = "n-i-v-c:block"
vim.o.winborder = 'rounded'
vim.o.path = vim.o.path .. ',**,'
vim.o.cursorline = true
vim.o.colorcolumn = "80"

if vim.fn.has("win32") == 1 then
  vim.o.shell = "cmd.exe"
  vim.o.shellcmdflag = "/c"
  vim.o.shellpipe = ">%s 2>&1"
end

-- stop highlights
vim.keymap.set("n", "<Esc>", ":nohl<CR>", { silent = true })

-- fast exit out of term mode
vim.keymap.set('t', '<Esc><Esc>', "<C-\\><C-n>", { noremap = true })

-- autocommands configs
require("autocommands")

-- plugins
require("plugins").setup()

-- completions
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
