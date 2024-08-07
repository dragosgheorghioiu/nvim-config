return {
	"github/copilot.vim",
	build = ":Copilot setup",
	config = function()
		vim.api.nvim_create_user_command("CopilotToggle", function()
			if vim.g.copilot_enabled then
				vim.cmd("Copilot disable")
				print("Copilot OFF")
			else
				vim.cmd("Copilot enable")
				print("Copilot ON")
			end
		end, { nargs = 0 })
		vim.keymap.set("", "<leader>gct", ":CopilotToggle<CR>", { noremap = true, silent = true })
		-- disable by default
		vim.g.copilot_enabled = false
	end,
}
