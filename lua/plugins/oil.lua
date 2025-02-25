return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		view_options = {
			show_hidden = true,
		},
		columns = {
			"icon",
			"permissions",
			"size",
		},
		keymaps = {
			["<C-s>"] = false,
			["<C-h>"] = false,
			["<C-t>"] = false,
			["<C-p>"] = false,
			["<C-c>"] = false,
			["<C-l>"] = false,
			["<C-r>"] = "actions.refresh",
		},
	},
}
