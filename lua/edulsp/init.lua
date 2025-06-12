vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local client = vim.lsp.start {
      name = "edulsp",
      cmd = { os.getenv("HOME") .. "/personal/edulsp/build/edulsp" },
    }

    if not client then
      vim.notify "edulsp is not working"
      return
    end

    vim.lsp.buf_attach_client(0, client)
  end
})
