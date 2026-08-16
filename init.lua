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
require("lazy").setup("plugins")
