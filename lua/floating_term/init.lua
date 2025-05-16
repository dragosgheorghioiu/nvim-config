local M = {}

local function center_in(inner, outer)
  return (outer - inner) / 2
end

local function win_config()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  return {
    relative = "editor",
    width = width,
    height = height,
    col = center_in(width, vim.o.columns),
    row = center_in(height, vim.o.lines),
    border = "rounded"
  }
end

local state = {
  buf = -1,
  win = -1,
}

local function open_floating_term(opts)
  local buf = -1
  local win = -1

  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  if vim.api.nvim_win_is_valid(opts.win) then
    win = opts.win
  else
    win = vim.api.nvim_open_win(buf, true, win_config())
  end

  return { buf = buf, win = win }
end

local function toggle_floating_term()
    if not vim.api.nvim_win_is_valid(state.win) then
      state = open_floating_term(state)
      if vim.bo[state.buf].buftype ~= 'terminal' then
        vim.cmd('terminal')
      end
      vim.cmd('startinsert')
    else
      vim.api.nvim_win_hide(state.win)
    end
end


local function setup_user_commnads()
  vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>")
  vim.api.nvim_create_user_command("FloatingTerminal", function()
    toggle_floating_term()
  end, {})
  vim.keymap.set({ "t", "n" }, "<C-t><C-t>", function()
    toggle_floating_term()
  end)
end

M.setup = function()
  setup_user_commnads()
end

return M
