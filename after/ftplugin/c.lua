vim.keymap.set("n", "<leader>ch", function()
  local file_path = vim.fn.expand('%:p')
  local ext = vim.fn.expand('%:e')
  local new_path = nil

  if ext == 'c' then
    new_path = file_path:gsub('%.c$', '.h')
  elseif ext == 'h' then
    new_path = file_path:gsub('%.h$', '.c')
  else
    print("Not a .c or .h file")
    return
  end

  vim.cmd('edit ' .. new_path)
end, { desc = "Switch between source and header" })

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
})
