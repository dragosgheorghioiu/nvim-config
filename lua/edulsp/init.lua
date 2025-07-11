vim.api.nvim_create_autocmd("FileType", {
  pattern = "glsl",
  callback = function()
    local client = vim.lsp.start {
      name = "shading-language-server",
      cmd = { "shading-language-server" },
    }

    if not client then
      vim.notify "sls is not working"
      return
    end

    vim.lsp.buf_attach_client(0, client)
    vim.notify "is attached to current buffer"
  end
})
