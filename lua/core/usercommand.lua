local M = {
	vim.api.nvim_create_user_command("W", "wall", {}),
	vim.api.nvim_create_user_command("Wq", "wall | quit", {}),
}

return M
