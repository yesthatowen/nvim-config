return {
	{ "echasnovski/mini.icons", opts = {} },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },
}
