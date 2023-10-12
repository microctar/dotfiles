# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Utilities
function Local:Load-Module {
  [OutputType([Boolean])]
  param(
      [parameter(Mandatory=$true)]
      [String] $module
      )

  if (Get-Module -ListAvailable -Name $module) {
    Import-Module -Name $module
    return $true
  }

  Write-Warning -Message "The module as is not installed. Install it by executing:`n  Install-Module -Name $module"
  return $false
}

function Local:Get-Compatibility {
  [OutputType([Boolean])]
  param()
  if ((7 -eq $Host.Version.Major) -and ( 2 -le $Host.Version.Minor )) {
    return $true
  }

  return $false
}

function Global:which ([String] $command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Needed Modules
$Local:modules = @(
      @{
          Name = "Terminal-Icons"
          PostConfigure = { $null }
      },
      @{
          Name = "posh-git"
          PostConfigure = { $null }
      }
)

# Settings for PowerShell 7.2 or later
if (Get-Compatibility) {
  $modules += @{
      Name = "PSFzf"
      PostConfigure = {
        Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
      }
  }

  Set-PSReadLineOption -PredictionSource History
}

foreach ($module in $modules) {
  if (Load-Module($module.Name)) {
    $module.PostConfigure | Invoke-Expression
  }
}

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ShellForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function ShellBackwardWord

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
