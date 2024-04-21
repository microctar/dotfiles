function Local:List-File {
	Get-ChildItem | Select-Object -Property "Name"
}

function Local:Open-EShop {
	Start-Process -FilePath msedge -ArgumentList "https://store-jp.nintendo.com"
}

function Local:Get-NSGPriceHistory {
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[string]$GameName
	)
	
	Start-Process -FilePath msedge -ArgumentList ("https://eshop-prices.com/games?q=" + ($GameName -replace ' ', '+'))
}

Set-Alias -Name l -Value List-File
Set-Alias -Name open -Value Invoke-Item
