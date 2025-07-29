local M = {}

-- Floating log window state
local log_buf = nil
local log_win = nil

-- Create or reuse the floating log window
function M.open_log_window()
  if log_buf and vim.api.nvim_buf_is_valid(log_buf) then
    return -- already open
  end

  log_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(log_buf, 'Plugin Installer Log')

  local width = math.floor(vim.o.columns * 0.6)
  local height = math.floor(vim.o.lines * 0.4)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  log_win = vim.api.nvim_open_win(log_buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })
end

-- Append a line to the floating log window
function M.log_to_window(msg)
  if not (log_buf and vim.api.nvim_buf_is_valid(log_buf)) then
    M.open_log_window()
  end

  vim.api.nvim_buf_set_lines(log_buf, -1, -1, false, { msg })
end

function M.update_progress(done, total)
  local line_count = vim.api.nvim_buf_line_count(bufnr)

  local progress_msg = string.format("Plugins built: %d/%d", done, total)

  if not progress_line_idx or progress_line_idx > line_count then
    -- Add progress line at the end
    vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, { progress_msg })
    progress_line_idx = line_count + 1
  else
    -- Update existing progress line in-place
    vim.api.nvim_buf_set_lines(bufnr, progress_line_idx - 1, progress_line_idx, false, { progress_msg })
  end
end


return M
