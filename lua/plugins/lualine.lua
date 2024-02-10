return {
	"nvim-lualine/lualine.nvim",
	priority = 1000,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = {
		function()
			require("lualine").setup()
		end,
	},
}
