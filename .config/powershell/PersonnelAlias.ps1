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

function Local:Convert-Base64 {
  	[CmdletBinding(DefaultParameterSetName = 'Text')]
	[Alias("base64")]
	[OutputType([String])]
	param(	
		[Parameter(Mandatory=$false)]
		[switch]$Decode,
	
		[Parameter(Mandatory=$true, ValueFromPipeline=$true, ParameterSetName = 'Text')]
		[string]$Text
	)

	if ($Decode) {
		return (Read-Base64 $Text)
	}

	return (Write-Base64 $Text)
}

function Local:New-ItemUnixStyle {
	[Alias("touch")]
	[OutputType([System.IO.FileInfo], [System.IO.DirectoryInfo])]

	param(
		[Parameter(Mandatory=$true)]
		[string]$FileName
	)

	$Leaf = Split-Path -Path $FileName -Leaf
	[string]$ParentDir = Split-Path -Path $FileName -Parent

	$ParentDir = if ([System.String]::IsNullOrEmpty($ParentDir)) { (Get-Location).Path } else { Resolve-Path -Path $ParentDir }

	$FullPath = Join-Path -Path $ParentDir -ChildPath $Leaf

	if (([System.IO.DirectoryInfo]$FullPath).Exists) {
		return [System.IO.DirectoryInfo]$FullPath
	}
	
	if (([System.IO.FileInfo]$FullPath).Exists) {
		return [System.IO.FileInfo]$FullPath
	}

	return (New-Item -Path $ParentDir -ItemType File -Name $Leaf)
}

Set-Alias -Name l -Value List-File
Set-Alias -Name open -Value Invoke-Item
Set-Alias -Name wc -Value Measure-Object
