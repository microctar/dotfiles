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
