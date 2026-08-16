require("config.lazy")

-- ============================================================================
-- 1. CORE OPTIONS (Mouse, Tiling, Formatting)
-- ============================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Click to position cursor, drag splits, scroll
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

-- ============================================================================
-- 2. BOOTSTRAP LAZY.NVIM
-- ============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- 3. PLUGIN SPECIFICATIONS
-- ============================================================================
require("lazy").setup({
	-- Clean Icons & UI Theme
	{ "echasnovski/mini.icons", opts = {} },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Keybinding Cheat Sheet / Notes Popup
	{ "folke/which-key.nvim", event = "VeryLazy", opts = {} },

	-- Fuzzy Finder (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
	},

	-- Syntax Highlighting (Treesitter)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"c_sharp",
					"python",
					"javascript",
					"yaml",
					"html",
					"css",
					"json",
					"markdown",
				},
				highlight = { enable = true },
			})
		end,
	},

	-- LSP Management & Language Servers
	{ "williamboman/mason.nvim", opts = {} },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"clangd",
				"pyright",
				"ts_ls",
				"yamlls",
				"html",
				"cssls",
				"jsonls",
				"marksman",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local servers = { "clangd", "pyright", "ts_ls", "yamlls", "html", "cssls", "jsonls", "marksman" }
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({})
			end
		end,
	},

	-- Unity C# Support via Roslyn
	{ "sevrdn/roslyn.nvim", ft = "cs", opts = {} },

	-- Autocompletion Engine (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Terminal Tile (ToggleTerm - Toggle with Ctrl+\)
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { open_mapping = [[<c-\>]], direction = "float" },
	},

	-- PostgreSQL & Database Interface
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "tpope/vim-dadbod" },
		cmd = { "DBUI", "DBUIToggle" },
	},

	-- Local AI / Copilot Integration
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
})
