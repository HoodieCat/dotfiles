local aucmd = vim.api.nvim_create_autocmd

--highlight yanked
aucmd('TextYankPost',{
	group = vim.api.nvim_create_augroup('highlightYanked', { clear = true}),
	callback = function()
		vim.hl.on_yank({ timeout= 300 } )
	end
})

aucmd('BufReadPost',{
	desc = 'Set cursor to wherer it left last time',
	pattern = '*',
	callback = function()
		local position = vim.fn.line('\'"')
		if position > 0 and position <=vim.fn.line('$') then
			vim.cmd('normal!' .. position ..'G')
		end
	end
})

aucmd('BufWritePre', {
	pattern ='*',
	callback =function(args)
		if pcall(require,'conform') then
			require('conform').format( { bufnr = args.buf})
	end
end
})
