return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local teles = require("telescope.builtin")

		local is_searching_hidden = false -- Variable to track the current state
		local file_search_opts = {
			hidden = false, -- Do not search hidden files
			no_ignore = false, -- Respect .gitignore
			prompt_title = "File Search", -- Optional: custom title
		}

		-- Function to toggle between normal and hidden files with no .gitignore respect
		function ToggleTelescopeSearch()
			is_searching_hidden = not is_searching_hidden

			if is_searching_hidden then
				file_search_opts = {
					hidden = true, -- Search hidden files
					no_ignore = true, -- Don't respect .gitignore
					prompt_title = "Complete File Search", -- Optional: custom title for clarity
				}
				print("Searching in hidden files is enabled")
			else
				file_search_opts = {
					hidden = false, -- Do not search hidden files
					no_ignore = false, -- Respect .gitignore
					prompt_title = "File Search", -- Optional: custom title
				}
				print("Searching in hidden files is disabled")
			end
		end

		-- Keymap to toggle
		vim.api.nvim_set_keymap("n", "<leader>pth", "<cmd>lua ToggleTelescopeSearch()<CR>", { noremap = true })
		vim.keymap.set("n", "<leader>pf", function()
			teles.find_files(file_search_opts)
		end, {})
		vim.keymap.set("n", "<leader>ps", teles.live_grep, {})
		vim.keymap.set("n", "<leader>pe", teles.diagnostics, {})
	end,
}
