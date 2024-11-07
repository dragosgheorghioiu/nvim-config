return {
	{
		"3rd/image.nvim",
		ft = "markdown",
		config = function()
			require("image").setup({
				backend = "kitty",
				processor = "magick_rock", -- or "magick_cli"
				integrations = {
					markdown = {
						enabled = true,
						clear_in_insert_mode = false,
						download_remote_images = true,
						only_render_image_at_cursor = false,
						filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
					},
				},
			})
		end,
		rocks = {
			hererocks = true, -- recommended if you do not have global installation of Lua 5.1.
		},
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		ft = "md",
		opts = {
			-- add options here
			-- or leave it empty to use the default settings
		},
		keys = {
			-- suggested keymap
			{ "<leader>ip", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},
}
