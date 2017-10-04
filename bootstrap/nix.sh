installNixBrewPackages()
{
  local pkgs=(
    apache-spark
    aria2
    awscli
    axel
    bash
    bash-completion
    binutils
    cheat
    cloc
    cmake
    coreutils
    cpanminus
    diffutils
    ed
    fasd
    ffmpeg
    file-formula
    findutils
    fish
    fpp
    fzf
    git
    git-extras
    git-flow-avh
    go
    gzip
    htop
    httpie
    imagemagick
    irssi
    jq
    less
    make
    midnight-commander
    mosh
    mutt
    mycli
    nano
    ncurses
    neovim
    nmap
    offlineimap
    open-mpi
    openshift-cli
    openssh
    pandoc
    python
    python3
    ranger
    rsync
    shellcheck
    the_silver_searcher
    thefuck
    tig
    tldr
    tmux
    translate-shell
    tree
    unzip
    vim
    w3m
    watch
    wdiff
    wget
    you-get
    youtube-dl
    zsh
    zsh-completions
  )
  brew install `join ' ' "${pkgs[@]}"`
}
