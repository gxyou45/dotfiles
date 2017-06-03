source "$partial_dir/env.sh"

prepareMacOSEnvCLI()
{
  which brew &> /dev/null || ( \
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && \
    xcode-select --install \
  )

  brew update
  brew upgrade

  pkgs=(
    ansifilter
    aria2
    axel
    bash
    bash-completion
    binutils
    cloc
    cheat
    cmake
    cmatrix
    cmus
    coreutils
    cpanminus
    cpulimit
    csshx
    curl
    diffutils
    ed
    fasd
    figlet
    file-formula
    findutils
    fish
    fortune
    fzf
    gawk
    git
    git-extras
    git-flow
    gnu-indent
    gnu-sed
    gnu-tar
    gnu-which
    gnutls
    go
    grep
    gzip
    httpie
    httpstat
    imagemagick
    irssi
    jq
    less
    make
    mas
    midnight-commander
    mobile-shell
    mutt
    mycli
    nano
    ncurses
    netcat
    nmap
    pandoc
    reattach-to-user-namespace
    rsync
    screenfetch
    shellcheck
    spark
    the_silver_searcher
    tig
    tldr
    tmate
    tmux
    tpp
    translate-shell
    tree
    unzip
    w3m
    watch
    wget
    yarn
    you-get
    zsh
    zsh-completions
  )

  brew install `join ' ' "${pkgs[@]}"`
  unset pkgs

  # Packages with arguments
  brew install openssh --with-brewed-openssl
  brew install python --with-brewed-openssl
  brew install python3 --with-brewed-openssl
  brew install vim --with-lua
  brew install wdiff --with-gettext

  brew cleanup; brew prune

  envSetup
}

prepareMacOSEnvGUI()
{
  # MAS apps

  pkgs=(
    406056744  # Evernote
    451108668  # QQ
    568494494  # Pocket
    747648890  # Telegram
    784801555  # OneNote
    803453959  # Slack
    836500024  # WeChat
    1147396723 # WhatsApp
  )

  mas install `join ' ' "${pkgs[@]}"`
  mas upgrade
  unset pkgs

  # Cask packages

  brew tap caskroom/fonts
  brew update

  pkgs=(
    # Quick-look plugins
    betterzipql
    qlcolorcode
    qlimagesize
    qlmarkdown
    qlprettypatch
    qlstephen
    quicklook-csv
    quicklook-json
    suspicious-package
    webpquicklook

    # Fonts
    font-source-code-pro
    font-source-code-pro-for-powerline

    # Editors
    atom
    macdown
    mactex
    macvim
    meld
    sublime-text
    typora
    visual-studio-code

    # Utilities
    1password
    alfred
    amethyst
    appcleaner
    bartender
    bettertouchtool
    bitbar
    caffeine
    calibre
    cheatsheet
    controlplane
    day-o
    duet
    hyperswitch
    iina
    karabiner-elements
    licecap
    pdfexpert
    shadowsocksx
    skim
    spectacle
    squirrel
    the-unarchiver
    toau
    ubersicht
    vnc-viewer

    # Dev tools
    charles
    dash
    docker
    fiddler
    filezilla
    imagealpha
    imageoptim
    iterm2
    java
    mamp
    postman
    smaller
    sourcetree
    vagrant
    vagrant-manager
    virtualbox

    # Internet
    caprine
    chromium
    dropbox
    firefox
    google-chrome
    google-drive
    google-hangouts
    ramme
    skype
    thunderbird

    # Entertainment
    spotify
    openemu
    sopcast
  )

  brew cask install `join ' ' "${pkgs[@]}"`
  unset pkgs

  brew cask cleanup; brew cleanup; brew prune
}
