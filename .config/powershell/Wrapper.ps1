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

function Local:ConvertTo-HexString {
    [OutputType([String])]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$FromString
    )

    $bytesArray = [System.Text.Encoding]::UTF8.GetBytes($FromString)

    return ([System.BitConverter]::ToString($bytesArray) -replace '-','')
}

function Local:Create-Certificate {
    param(
        [Parameter(Mandatory=$false)]
        [int]$Days = 180,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$CAName,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$Config,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$ExtFile,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$CertName = "server"
    )

    if ( -Not (Get-Command openssl) ) {
        Write-Warning -Message "Cannot find command openssl"
        return $NULL
    }

    [string]$ca_key = "{0}.key" -f $CAName
    [string]$ca_csr = "{0}.csr" -f $CAName
    [string]$ca_crt = "{0}.crt" -f $CAName
    [string]$srv_key = "{0}.key" -f $CertName
    [string]$srv_csr = "{0}.csr" -f $CertName
    [string]$srv_crt = "{0}.crt" -f $CertName
    

    openssl genrsa -out $ca_key 4096
    openssl req -config $Config -key $ca_key -new -out $ca_csr
    openssl req -x509 -new -key $ca_key -out $ca_crt -config $Config -extensions "v3_ca" -days $Days

    openssl genrsa -out $srv_key 4096
    openssl req -config $Config -key $srv_key -new -out $srv_csr
    openssl x509 -req -CA $ca_crt -CAkey $ca_key -CAcreateserial -extfile $ExtFile -in $srv_csr -out $srv_crt -days $Days
}
