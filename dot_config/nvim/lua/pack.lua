vim.pack.add { 
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" } 
}
if pcall(require, "catppuccin") then
	vim.cmd.colorscheme"catppuccin-macchiato"
end

vim.pack.add { 
	{ src = "https://github.com/akinsho/toggleterm.nvim",  name = "toggleterm"}
}

