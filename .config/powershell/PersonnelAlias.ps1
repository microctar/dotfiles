function Local:List-File {
	Get-ChildItem | Select-Object -Property "Name"
}

Set-Alias -Name l -Value List-File
