return {
	"github/copilot.vim",
	build = ":Copilot setup",
	config = function()
		local copilot_on = true
		vim.api.nvim_create_user_command("CopilotToggle", function()
			if copilot_on then
				vim.cmd("Copilot disable")
				print("Copilot OFF")
			else
				vim.cmd("Copilot enable")
				print("Copilot ON")
			end
			copilot_on = not copilot_on
		end, { nargs = 0 })
		vim.keymap.set("", "<leader>gct", ":CopilotToggle<CR>", { noremap = true, silent = true })
	end,
}
