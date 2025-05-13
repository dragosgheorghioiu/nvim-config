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
	vim.keymap.set("n", "<m-c-j>", "<cmd>cnext<cr>"),
	vim.keymap.set("n", "<m-c-k>", "<cmd>cprevious<cr>"),

	vim.keymap.set("n", "<Leader>qt", "<cmd>lua toggle_quickfix()<cr>"),

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

  vim.keymap.set("n", "<Leader>st", function ()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 5)
  end)
}
return M
