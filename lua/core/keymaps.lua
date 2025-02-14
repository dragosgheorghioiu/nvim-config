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
	vim.keymap.set("n", "<Leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>"),
	-- Oil remap
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
	-- Quickfix list keymaps
	vim.keymap.set("n", "<Leader>qn", "<cmd>cnext<cr>"),
	vim.keymap.set("n", "<Leader>qp", "<cmd>cprevious<cr>"),

	vim.keymap.set("n", "<Leader>ql", "<cmd>lua toggle_quickfix()<cr>"),

  -- Buffer commands
	vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<cr>"),
	vim.keymap.set("n", "<Leader>bp", "<cmd>bprevious<cr>"),
	vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<cr>"),
	vim.keymap.set("n", "<Leader>bs", "<cmd>buffers<cr>"),

  -- Pane keymaps
	vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>"),
	vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>"),
	vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>"),
	vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>"),
}
return M
