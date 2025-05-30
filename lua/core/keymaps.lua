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
  vim.keymap.set("n", "-", "<cmd>Ex<CR>", { desc = "Open parent directory" }),
  -- Quickfix list keymaps
  vim.keymap.set("n", "<m-c-j>", "<cmd>cnext<cr>"),
  vim.keymap.set("n", "<m-c-k>", "<cmd>cprevious<cr>"),

  vim.keymap.set("n", "<Leader>qt", "<cmd>lua toggle_quickfix()<cr>"),

  -- Buffer commands
  vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<cr>"),
  vim.keymap.set("n", "<Leader>bp", "<cmd>bprevious<cr>"),
  vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<cr>"),
  vim.keymap.set("n", "<Leader>bs", "<cmd>buffers<cr>"),

  -- run command from visual selection
  vim.keymap.set("v", "<Leader>sh", [[<cmd>'<,'>w !bash<CR>]], { silent = true })
}
return M
