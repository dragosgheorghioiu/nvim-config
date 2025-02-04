function toggle_quickfix()
	for _, win in ipairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			vim.cmd("cclose")
		else
			vim.cmd("copen")
		end
	end
end
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

	vim.keymap.set("n", "<C-M-O>", "<cmd>lua toggle_quickfix()<cr>"),

	vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<cr>"),
	vim.keymap.set("n", "<Leader>bp", "<cmd>bprevious<cr>"),
	vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<cr>"),
	vim.keymap.set("n", "<Leader>bs", "<cmd>buffers<cr>"),
}
return M
