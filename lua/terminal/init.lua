local terminal_bufnr = nil

local function find_window_with_buf(bufnr)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      return win
    end
  end
  return nil
end

local function open_terminal_vsplit()
  if terminal_bufnr and vim.api.nvim_buf_is_valid(terminal_bufnr) then
    local win = find_window_with_buf(terminal_bufnr)

    if win then
      vim.api.nvim_set_current_win(win)
      vim.cmd("startinsert")
      return
    else
      vim.cmd("vsplit")
      vim.api.nvim_win_set_buf(0, terminal_bufnr)
      vim.cmd("startinsert")
      return
    end
  end

  vim.cmd("vsplit")
  vim.cmd("terminal")

  terminal_bufnr = vim.api.nvim_get_current_buf()

  vim.bo[terminal_bufnr].bufhidden = "hide"
  vim.bo[terminal_bufnr].swapfile = false

  vim.cmd("startinsert")
end


local function setup()
  vim.keymap.set("n", "<leader>t", function() open_terminal_vsplit() end,
    { noremap = true, silent = true, desc = "Toggle floating terminal" })

  vim.keymap.set("t", "<Esc>n", [[<C-\><C-n>]], {
    silent = true,
  })

  vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>:close<CR>]], {
    silent = true,
  })
end


return {
  setup = setup
}
