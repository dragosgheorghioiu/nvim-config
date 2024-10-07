return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local teles = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", teles.find_files, {})
		vim.keymap.set("n", "<leader>ps", teles.live_grep, {})
		vim.keymap.set("n", "<leader>pe", teles.diagnostics, {})
	end,
}
