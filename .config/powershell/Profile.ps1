# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding


# Utilities
function Load-Module {
  [OutputType([Boolean])]
  Param(
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

function which ([String] $command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

[Void](Load-Module("Terminal-Icons"))
[Void](Load-Module("posh-git")) 

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ShellForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function ShellBackwardWord

# Settings for PowerShell 7.2 or later
if ((7 -eq $Host.Version.Major) -and ( 2 -le $Host.Version.Minor )) {
  Set-PSReadLineOption -PredictionSource History

# Fzf
  if (Load-Module("PSFzf")) {
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
  }
}

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
