-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("yank-highlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- lsp autocommands
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client ~= nil and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          return { abbr = item.label:gsub("%b()", "") }
        end,
      })
    end

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)

    local lsp_detach_group = vim.api.nvim_create_augroup("lsp-detach", { clear = true })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = lsp_detach_group,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end,
})
