local M = {
  -- clear highlights when pressing escape in normal mode
  vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>"),

  -- run command from visual selection
  vim.keymap.set("v", "<Leader>sh", [[<cmd>'<,'>w !bash<CR>]], { silent = true })
}
return M
