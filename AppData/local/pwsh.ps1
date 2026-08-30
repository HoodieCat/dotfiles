Import-Module PSReadline
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineOption -PredictionSource History
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+y' -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key 'Ctrl+q' -Function TabCompleteNext
#oh-my-posh
oh-my-posh init pwsh --config "~/AppData/Local/oh-my-posh-theme/mytheme.omp.json"| Invoke-Expression

#alias
Set-Alias lg lazygit
Set-Alias vi nvim
Set-Alias omp oh-my-posh
if(Test-Path alias:pwd) {Remove-Item alias:pwd}
function pwd {
	$(Get-Location).Path
}
$env:FZF_DEFAULT_OPTS = "--bind 'ctrl-h:backward-delete-char'"
# yazi
function y {
	$tmp = [System.IO.Path]::GetTempFileName()
		yazi $args --cwd-file="$tmp"
		$cwd = Get-Content -Path $tmp -Encoding UTF8
		if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
			Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
		}
	Remove-Item -Path $tmp
}

function which{
	(Get-Command $args[0]).source
}

# fzf wrapper
Set-PSReadlineKeyHandler -Key 'Ctrl+t' -ScriptBlock {
	$command = 'fd -tf -I --hidden  --exclude .cache --exclude node_modules --exclude .git --exclude .vscode 2>$null | fzf --tiebreak=length --border --preview "bat -n --color=always {}" --bind "ctrl-h:backward-delete-char"'
		try{
			$result = Invoke-Expression $command
				if($result){
					if($result -match " ") { $result = '"' + $result + '"'}
					[Microsoft.Powershell.PSConsoleReadLine]::Insert($result)
				}
		}
	catch {}
}

Set-PSReadLineKeyHandler -Key 'Alt+c' -ScriptBlock {
	$command = 'fd -td -tl --hidden --exclude .git --exclude node_modules --no-ignore --exclude undo --exclude swap 2>$null | fzf --scheme=PATH --border --preview "tre {}" --bind "ctrl-h:backward-delete-char" '
		try{
			$result = Invoke-Expression $command
				if ($result){
					if($result -match " ") { $result = '"'+$result+'"'}
					[Microsoft.Powershell.PSConsoleReadLine]::DeleteLine()
						[Microsoft.Powershell.PSConsoleReadLine]::Insert("cd $result")
							[Microsoft.Powershell.PSConsoleReadLine]::AcceptLine()
				}
		}
	catch {}
}

Set-PSReadLineKeyHandler -Key 'Ctrl+r' -ScriptBlock {
	$initQuery = [Microsoft.Powershell.PSConsoleReadLine]::InputLine
		$historyPath = (Get-PSReadLineOption).HistorySavePath
		$command = "Get-Content '$historyPath' -ErrorAction SilentlyContinue | Select-Object -Unique | fzf --no-sort --tac --prompt='History>' --scheme=history --query '$initQuery' --bind 'ctrl-h:backward-delete-char' "
		try{
			$result = Invoke-Expression $command
				if($result){
					[Microsoft.Powershell.PSConsoleReadLine]::DeleteLine()
						[Microsoft.Powershell.PSConsoleReadLine]::Insert($result)
				}
		}
	catch{}
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
