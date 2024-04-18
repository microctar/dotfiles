function Local:List-File {
	Get-ChildItem | Select-Object -Property "Name"
}

Set-Alias -Name l -Value List-File
Set-Alias -Name open -Value Invoke-Item
