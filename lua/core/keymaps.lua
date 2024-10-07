local M = {
	-- clear highlights when pressing escape in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>"),
	-- for C/C++ change between source file and header
	vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>"),
	-- Oil remap
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
}
return M
