local call = function( plug)
	return pcall(require,plug)
end
vim.pack.add { 
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" } 
}
if call"catppuccin" then
	vim.cmd.colorscheme"catppuccin-macchiato"
end

vim.pack.add { 
	{ src = "https://github.com/akinsho/toggleterm.nvim",  name = "toggleterm"}
}

