#Requires -RunAsAdministrator

param (
  [switch]$onlyCLI = $false,
  [switch]$update = $false
)

function installChocolatey
{
  blankLines
  'Install Chocolatey...'

  if ((Get-Command "chocolatey" -ErrorAction SilentlyContinue) -eq $null)
  {
    Set-ExecutionPolicy AllSigned
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
  }
  else
  {
    'Chocolatey already exists.'
  }
}

function installCLIPackages
{
  blankLines
  'Install CLI packages using Chocolatey...'

  $pkgs = @(
    'ag',
    'aria2',
    'chocolatey',
    'cloc',
    'docker',
    'docker-compose',
    'docker-machine',
    'far',
    'fzf',
    'git',
    'git-lfs',
    'golang',
    'gow',
    'jdk8',
    'jq',
    'mc',
    'nmap',
    'nodejs',
    'nvm',
    'phantomjs',
    'python',
    'python2',
    'ruby',
    'resilio-sync-home',
    'sbt',
    'sourcecodepro',
    'vagrant',
    'yarn',
    'you-get'
  )
  $ofs = ' '
  cinst -y "$pkgs"
}

function installGUIPackages
{
  blankLines
  'Install GUI packages using Chocolatey...'

  $pkgs = @(
    '7zip',
    'aimp',
    'altdrag',
    'atom',
    'autohotkey',
    'caesium.install',
    'calibre',
    'ccleaner',
    'charles',
    'chocolateygui',
    'chromium',
    'clover',
    'doublecmd',
    'dropbox',
    'everything',
    'fiddler4',
    'filezilla',
    'firefox',
    'foobar2000',
    'foxitreader',
    'googlechrome',
    'googledrive',
    'hexchat',
    'intellijidea-community',
    'irfanview',
    'irfanviewplugins',
    'licecap',
    'meld',
    'miktex',
    'mobaxterm',
    'nimbletext',
    'paint.net',
    'pandoc',
    'pdfsam',
    'pngoptimizer',
    'postman',
    'potplayer',
    'putty',
    'rescuetime',
    'rufus',
    'skype',
    'slack',
    'sourcetree',
    'spacesniffer',
    'spotify',
    'strokesplus',
    'sublimetext3',
    'sumatrapdf',
    'switcheroo',
    'sysinternals',
    'telegram',
    'thunderbird',
    'vcxsrv',
    'virtualbox',
    'visualstudiocode',
    'vnc-viewer',
    'whatsapp',
    'windirstat',
    'winscp',
    'wox',
    'xming',
    'xnviewmp'
  )
  $ofs = ' '
  cinst -y "$pkgs"
}

function applyWindowsDefenderExclusions
{
  blankLines
  $exclusions = @(
    "$Env:LOCALAPPDATA\Yarn",
    "$Env:USERPROFILE\.atom",
    "$Env:USERPROFILE\.vscode\extensions"
  )

  'Exclude below paths from Windows Defender real time protection:'
  foreach ($path in $exclusions) {
    "... $path"
    Add-MpPreference -ExclusionPath "$path"
  }
  'Done.'
}

function blankLines($num = 3, $char = '.')
{
  for ($i=0; $i -lt $num; $i++) {
    $char
  }
}

applyWindowsDefenderExclusions
installChocolatey
installCLIPackages

if (!$onlyCLI) {
  installGUIPackages
}

if ($update) {
  'Update all packages using Chocolatey...'
  cup -y all
}
