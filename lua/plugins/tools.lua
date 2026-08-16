return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { open_mapping = [[<c-\>]], direction = "float" },
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle" },
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {
			strategies = {
				chat = { adapter = "ollama" },
				inline = { adapter = "ollama" },
			},
		},
	},
}
