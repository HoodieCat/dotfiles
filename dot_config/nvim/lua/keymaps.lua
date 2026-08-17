local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- diagnostic config : jump to next/previous displaying diagnostic in a floating window
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },
	virtual_text = true,
	virtual_lines = false,
	jump = {
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float {
				bufnr = bufnr,
				scope = 'cursor',
				focus = false,
			}
		end,
	}
})
map('n','<leader>dq', vim.diagnostic.setloclist, { desc = '[D]iagnositc [L]ocally'})
map('n','<leader>dt', function() 
	vim.diagnostic.enable( not vim.diagnostic.is_enable())
end, {desc= "[D]iagnostic [T]oggle"})
map('t','<Esc><Esc>','<C-\\><C-n>', opts)
map('n', 'j', 'gj', opts)
map('n', 'k', 'gk', opts)
map('n','<ESC>','<cmd>nohls<CR>', opts)
map({'n','i','v'},'<C-s>','<Cmd>write<CR>', opts)
map('n','<leader>bd','<cmd>bdelete<CR>', opts)

--resize
map('n','<C-k>','<C-w><C-+>', opts)
map('n','<C-j>', function()
	if vim.fn.winnr('$') ~=1 and vim.fn.winheight(0) < (vim.o.lines -3) then
		vim.cmd('resize'..'-'..vim.v.count1)
	end
end,opts)

map('n', '<c-l>', '<C-w><C->>', { desc = 'Increase width' })
map('n', '<c-h>', '<c-w><c-<>', { desc = 'Decrease width' })

--Tab
map('n', '[t', ':tabprevious<CR>', { desc = '[T]ab previous' })
map('n', ']t', ':tabNext<CR>', { desc = '[T]ab previous' })
map('n', '<leader>tn', ':tabnew<CR>', { desc = '[T]ab New' })
map('n', '<leader>tt', ':tabclose<CR>', { desc = '[T]ab [t]oggle' })

--utilities
map('n', '<leader>m',function()
	if pcall(require,'mason') then
		vim.cmd('Mason')
	end
end, opts)

--copy current buffer name with full path and name using 'cc'
map('n', 'cc', function()
	local file_name = vim.fn.expand('%:p')
	if file_name then
		vim.fn.setreg('+', file_name)
	end
end, opts )

-- flash integration
map('n','r', function()
	if pcall(require,'flash') then
		flash.remote()
	end
end, opts)

map({'o','n','x'},'S', function()
	if pcall(require,'flash') then
		require('flash').remote()
	end
end, opts)
