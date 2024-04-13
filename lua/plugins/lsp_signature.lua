return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	config = function(_, _)
		require("lsp_signature").setup({})
	end,
}
