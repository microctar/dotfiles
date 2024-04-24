function Local:Read-Url {
    [Alias("UrlDecode")]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Url
    )

    return [System.Web.HttpUtility]::UrlDecode($Url)
}

function Local:Write-Url {
    [Alias("UrlEncode")]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Url
    )

    return [System.Web.HttpUtility]::UrlEncode($Url)
}

function Local:ConvertTo-AsciiString {
    [OutputType([String])]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$FromHexString,

        [Parameter(ValueFromPipeline=$true)]
        [byte[]]$FromBytes
    )

    if (![string]::IsNullOrEmpty($FromHexString)) {
        [string]$Text = ""
        $hexArray = if ( $FromHexString.Contains(" ") ) { $FromHexString -split ' ' } else { $FromHexString -split '(.{2})' }
        foreach ($hex in $hexArray) {
            if ($hex -match "^[0-9A-Za-z]+$") {
                $Text += [char]([Convert]::ToInt16($hex, 16))
            }
        }

        return $Text
    }

    if ($FromBytes.Length -gt 0) {
        return [System.Text.Encoding]::ASCII.GetString($FromBytes);
    }
}
