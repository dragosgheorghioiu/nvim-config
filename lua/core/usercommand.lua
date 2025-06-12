local M = {
  vim.api.nvim_create_user_command("W", "wall", {}),
  vim.api.nvim_create_user_command("Wq", "wall | quit", {}),
  vim.api.nvim_create_user_command("Copy", function(opts)
    local filepath = opts.args
    local dir = vim.fn.fnamemodify(filepath, ":p:h")
    vim.fn.mkdir(dir, "p")
    vim.cmd("saveas " .. filepath)
  end, {
    nargs = 1,
    complete = "file",
    desc = "save buffer to file, creating directories if needed",
  }),
  vim.api.nvim_create_user_command('Move', function(opts)
    local oldpath = vim.api.nvim_buf_get_name(0)
    local newpath = opts.args

    if oldpath == '' then
      print("No file associated with the current buffer")
      return
    end

    if vim.fn.filereadable(newpath) == 1 or vim.fn.isdirectory(newpath) == 1 then
      print("Target file or directory already exists!")
      return
    end

    -- make sure the dir exists
    local dir = vim.fn.fnamemodify(newpath, ":p:h")
    vim.fn.mkdir(dir, "p")

    local ok = vim.fn.rename(oldpath, newpath)
    if ok ~= 0 then
      print("Failed to rename file")
      return
    end

    vim.cmd('edit ' .. vim.fn.fnameescape(newpath))
    vim.cmd('bdelete ' .. vim.fn.bufnr(oldpath))

    print("Moved " .. oldpath .. " to " .. newpath)
  end, {
    nargs = 1,
    complete = "file",
    desc = "Move file associated with the current buffer to a new path",
  }),
}

return M
