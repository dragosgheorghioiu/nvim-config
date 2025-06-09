local client = vim.lsp.start_client {
  name = "edulsp",
  cmd = { "/home/dregos/edulsp/build/edulsp" }
}

if not client then
  vim.notify "lsp is not working"
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.lsp.buf_attach_client(0, client)
  end
})
