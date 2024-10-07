local M = {
	-- clear highlights when pressing escape in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>"),
	-- for C/C++ change between source file and header
	vim.keymap.set("n", "<Leader>pch", "<cmd>ClangdSwitchSourceHeader<cr>"),
}
return M
