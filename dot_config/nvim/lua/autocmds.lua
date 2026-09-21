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
		local last_leave = vim.api.nvim_buf_get_mark(0, '"')
		if last_leave[1] ~= 0 and last_leave[1] <=vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0 , {last_leave[1], last_leave[2]})
			-- vim.cmd('normal!' .. position ..'G')
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

-- hooks for vim.pack
aucmd('PackChanged', {
	desc = "Hooks event on plugin init/change",
	callback = function(ev)
		local name,kind = ev.data.spec.name, ev.data.kind
		-- if name == 'markdown-preview.nvim' and ( kind =='install') then
			print("plugin"..ev.data.spec.name.."installed","kind =" .. ev.data.kind)
			if vim.fn.has('win32') then
				vim.system({"pwsh", "-NoProfile", "-Command", "yarn install"}, { cwd= ev.data.path .."/app"})
			else 
				vim.system("yarn", "install", { cwd = ev.data.path .. "/app" })
		end
	end}
)
