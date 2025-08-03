return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
	indent = {
	    char = "|",
	    tab_char = "|",
	    highlight = {
		"RainbowRed",
		"RainbowYellow",
		"RainbowBlue",
		"RainbowOrange",
		"RainbowGreen",
		"RainbowViolet",
		"RainbowCyan",
	    },
	},
	scope = {
	    enabled = false,
	},
	exclude = {
	    filetypes = {
		"help",
		"dashboard",
		"lazy",
		"mason",
		"notify",
		"Trouble",
		"neo-tree",
		"toggleterm",
	    },
	},
    },
}
