local M = {}

local bufnr
local progress_line_idx = 0

local function ensure_buf()
  if not (bufnr and vim.api.nvim_buf_is_valid(bufnr)) then
    bufnr = vim.api.nvim_create_buf(true, true)
    vim.cmd("botright split")
    vim.api.nvim_win_set_buf(0, bufnr)

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "" })
  end
end

function M.log(msg)
  ensure_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, { msg })
end

function M.update_progress(done, total)
  ensure_buf()
  local progress_msg = string.format("Plugins done: %d/%d", done, total)
  local border = "===================="
  vim.api.nvim_buf_set_lines(bufnr, progress_line_idx, progress_line_idx + 4, false, { progress_msg, "", border, "" })
end

return M

