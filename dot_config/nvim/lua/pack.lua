local call = function( plug)
	return pcall(require,plug)
end
vim.pack.add { 
	{ src = "https://github.com/akinsho/toggleterm.nvim",  name = "toggleterm"},
	{ src = "https://github.com/stevearc/aerial.nvim", name = "aerial"},
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim", name = "markdown-preview" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim", name = "markdown-preview" },
	{ src = "https://github.com/catgoose/nvim-colorizer.lua", name = "colorizer" },
}

if call"catppuccin" then
	require("catppuccin").setup({
		integrations = {
			aerial = true,
		}
	})
	vim.cmd.colorscheme"catppuccin-mocha"
end

if call"aerial" then 
	require("aerial").setup({
		layout = {
			default_direction = "prefer_left"
		},
		on_attach = function(bufnr)
			vim.keymap.set('n', '<leader>a', "<cmd>AerialToggle!<CR>")
			vim.keymap.set('n', '{', "<cmd>AerialPre<CR>")
			vim.keymap.set('n', '}', "<cmd>AerialNext<CR>")
		end})
end

if call"colorizer" then
	require("colorizer").setup()
end
