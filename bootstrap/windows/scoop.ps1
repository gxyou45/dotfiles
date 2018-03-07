. $PSScriptRoot\util.ps1

function installScoop
{
  Set-ExecutionPolicy RemoteSigned -scope CurrentUser

  if (Get-Command scoop -errorAction SilentlyContinue) {
    scoop update
  } else {
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
  }
}

function installScoopPackages
{
  scoop bucket add `
    extras `
    nerd-fonts `
    nonportable `
    versions `

  scoop install `
    7zip `
    adb `
    ag `
    android-sdk `
    android-studio `
    atom `
    autohotkey `
    azure-cli `
    calibre `
    ccleaner `
    chromium `
    cloc `
    cmder `
    concfg `
    conemu `
    doublecmd `
    ditto `
    everything `
    far `
    filezilla `
    firefox `
    foobar2000 `
    foxit-reader `
    fzf `
    git `
    gcloud `
    git-lfs `
    gow `
    hain `
    heidisql `
    heroku-cli `
    hexchat `
    hyper `
    irfanview `
    jq `
    kdiff3 `
    keepass `
    kitematic `
    kubectl `
    licecap `
    ln `
    mc `
    miniconda3 `
    mobaxterm `
    nimbleset `
    nimbletext `
    nmap `
    nodejs `
    nodejs-lts `
    openssh `
    oraclejdk `
    pandoc `
    phantomjs `
    postman `
    pshazz `
    putty `
    robo3t `
    rufus `
    runat `
    say `
    sbt `
    screentogif `
    shadowsocks `
    shasum `
    slack `
    snipaste `
    sourcetree `
    sublime-text `
    sudo `
    sumatrapdf `
    sysinternals `
    telegram `
    touch `
    vagrant `
    vcxsrv `
    vim `
    vimtutor `
    vscode `
    whatsapp `
    windirstat `
    winscp `
    wireshark `
    wox `
    wsltty `
    xming `
    yarn `
    zeal `

  # Make git work with openssh
  [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

  # Solarized theme
  concfg import solarized small

  # Make `source activate` work in powershell
  conda install -n root -c pscondaenvs pscondaenvs

  sudo scoop install `
    SourceCodePro-NF `

  # Keep a blank line
}

installScoop
installScoopPackages
