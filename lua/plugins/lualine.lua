local colors = {
	blue = "#80a0ff",
	cyan = "#a0c3b0",
	black = "#080808",
	white = "#c6c6c6",
	red = "#ff5189",
	violet = "#621c53",
	grey = "#303030",
	green = "#4b6568",
}

local bubbles_theme = {
	normal = {
		a = { fg = colors.white, bg = colors.green },
		b = { fg = colors.white, bg = colors.grey },
		c = { fg = colors.white },
	},

	insert = { a = { fg = colors.black, bg = colors.cyan } },
	visual = { a = { fg = colors.white, bg = colors.violet } }, command = { a = { fg = colors.black, bg = colors.white } },
	inactive = {

		a = { fg = colors.white, bg = colors.black },
		b = { fg = colors.white, bg = colors.black },
		c = { fg = colors.white },
	},
}

local function diagnostics()
  local config = vim.diagnostic.config
  local vt = config().virtual_text
  if vt then
    return ' : ⏽'
  else
    return ' : ⭘'
  end
end

return {
	"nvim-lualine/lualine.nvim",
	priority = 1000,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = bubbles_theme,
			component_separators = "",
		},
		sections = {
			lualine_a = { { "mode", right_padding = 2 } },
			lualine_b = { "filename", "branch" },
			lualine_c = {
				"%=", --[[ add your center compoentnts here in place of this comment ]]
			},
			lualine_x = {},
			lualine_y = {{ diagnostics,  }},
			lualine_z = {
				{ "progress", left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = { "filename" },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { },
			lualine_z = { "location" },
		},
		tabline = {},
		extensions = {},
	},
}
