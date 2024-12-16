local M = {
	-- clear highlights when pressing escape in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>"),
	-- for C/C++ change between source file and header
	vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>"),
	-- Oil remap
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
	-- Quickfix list keymaps
	vim.keymap.set("n", "<C-M-J>", "<cmd>cnext<cr>"),
	vim.keymap.set("n", "<C-M-K>", "<cmd>cprevious<cr>"),
	vim.keymap.set("n", "<C-M-O>", "<cmd>copen<cr>"),
	vim.keymap.set("n", "<C-M-P>", "<cmd>cclose<cr>"),
}
return M
