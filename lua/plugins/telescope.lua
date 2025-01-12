return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})

		local teles = require("telescope.builtin")

		vim.api.nvim_set_keymap("n", "<leader>phf", "<cmd>lua ToggleTelescopeSearch()<CR>", { noremap = true })
		vim.keymap.set("n", "<leader>phf", function()
			teles.find_files({
				hidden = true,
				no_ignore = true,
				prompt_title = "Complete File Search",
			})
		end, {})
		vim.keymap.set("n", "<leader>pf", function()
			teles.find_files({
				hidden = false,
				no_ignore = false,
				prompt_title = "Project File Search",
			})
		end, {})
		vim.keymap.set("n", "<leader>ps", teles.live_grep, {})
		vim.keymap.set("n", "<leader>pe", teles.diagnostics, {})
	end,
}
