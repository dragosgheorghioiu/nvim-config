return {
	--[[ One Dark Pro nvim ]]
	-- "navarasu/onedark.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("onedark").setup({
	-- 		style = "darker",
	-- 	})
	-- 	require("onedark").load()
	-- end,
	--

	--[[ Gruvbox Material ]]
	-- "sainnhe/gruvbox-material",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	vim.cmd([[ set background=dark ]])
	-- 	vim.cmd([[ colorscheme gruvbox-material ]])
	-- end,

	-- [[ Lucid ]]
	-- "jacoborus/lucid.nvim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- vim.cmd([[ set background=dark ]])
	-- vim.cmd([[ colorscheme lucid ]])
	-- end,

	-- [[ Sonokai ]]
	"sainnhe/sonokai",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[ let g:sonokai_diagnostic_text_highlight = 1 ]])
		vim.cmd([[ let g:sonokai_diagnostic_line_highlight = 1 ]])
		vim.cmd([[ let g:sonokai_style = 'shusia' ]])
		-- vim.cmd([[ let g:sonokai_better_performance = 1 ]])
		vim.cmd([[ let g:sonokai_transparent_background = 1 ]])
		vim.cmd([[ colorscheme sonokai ]])
	end,

	-- [[ Everforest ]]
	-- "sainnhe/everforest",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	vim.cmd([[ let g:everforest_background = 'hard' ]])
	-- 	vim.cmd([[ let g:everforest_transparent_background = 1 ]])
	-- 	vim.cmd([[ colorscheme everforest ]])
	-- end,

	-- [[ Rose Pine ]]
	-- "rose-pine/neovim",
	-- lazy = false,
	-- priority = 1000,
	-- config = function()
	-- 	require("rose-pine").setup({
	-- 		styles = {
	-- 			transparency = true,
	-- 		},
	-- 	})
	-- 	vim.cmd("colorscheme rose-pine")
	-- end,
}
