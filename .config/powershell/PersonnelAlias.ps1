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

function Local:Read-Base64 {
  	[OutputType([String])]
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[string]$Base64String
	)

	$bytes = [Convert]::FromBase64String($Base64String)
	return [System.Text.Encoding]::Unicode.GetString($bytes)
}

function Local:Write-Base64 {
	[OutputType([String])]
	param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[string]$OriginalText
	)
	
	$bytes = [System.Text.Encoding]::Unicode.GetBytes($OriginalText)
	return [Convert]::ToBase64String($bytes)
}

Set-Alias -Name l -Value List-File
Set-Alias -Name open -Value Invoke-Item
