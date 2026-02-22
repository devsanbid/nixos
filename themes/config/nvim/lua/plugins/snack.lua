return {
	"folke/snacks.nvim",
	opts = {
		picker = {},
	},
	keys = {
		{
			"<leader>fw",
			function()
				local Snacks = require("snacks")
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
	},
}
