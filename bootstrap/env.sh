source "$partial_dir/shell.sh"
source "$partial_dir/pkg.sh"

gitSetup()
{
  blankLines
  echo 'Applying global git configs...'

  # Back up the current config file
  if [ -f ~/.gitconfig ]; then
    printf 'Backing up current .gitconfig... '
    git_user_name=`git config --global user.name`
    git_user_email=`git config --global user.email`
    mv ~/.gitconfig ~/.gitconfig~
    echo 'Done.'
  fi

  echo 'Applying new git configs...'
  cat "$config_dir/git/alias" > ~/.gitconfig
  cat "$config_dir/git/common" >> ~/.gitconfig

  # MacOS
  if [[ $OSTYPE == *'darwin'* ]]; then
    git config --global credential.helper osxkeychain
  fi

  # WSL & Cygwin
  uname -r | grep Microsoft &> /dev/null # returns 0 on WSL
  if [[ $? == 0 || $OSTYPE == 'cygwin' ]]; then
    git config --global core.autocrlf input
    git config --global core.fileMode false
  fi

  # Git user
  if [[ -n "$git_user_name" && -n "$git_user_email" ]]; then
    echo "Global user was configured as $git_user_name ($git_user_email) previously."
    read -p 'Press Y/y to configure it differently: ' -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo 'Configuring git user...'
      read -p "username: " git_user_name
      read -p "email: " git_user_email
    else
      echo "$git_user_name ($git_user_email) will be kept as the global user."
    fi
  else
    echo 'Configuring git user...'
    read -p "username: " git_user_name
    read -p "email: " git_user_email
  fi

  git config --global user.name "$git_user_name"
  git config --global user.email "$git_user_email"
  unset git_user_name
  unset git_user_email

  echo 'Done.'
}

rbenvSetup()
{
  blankLines
  echo 'Installing rbenv...'
  local GH='https://github.com'
  local ROOT="$HOME/.rbenv"
  local PLUGINS="$ROOT/plugins"
  syncConfigRepo "$ROOT"                        "$GH/rbenv/rbenv"
  syncConfigRepo "$PLUGINS/ruby-build"          "$GH/rbenv/ruby-build"
  syncConfigRepo "$PLUGINS/rbenv-vars"          "$GH/rbenv/rbenv-vars"
  syncConfigRepo "$PLUGINS/rbenv-each"          "$GH/rbenv/rbenv-each"
  syncConfigRepo "$PLUGINS/rbenv-default-gems"  "$GH/rbenv/rbenv-default-gems"
  syncConfigRepo "$PLUGINS/rbenv-update"        "$GH/rkh/rbenv-update"
  syncConfigRepo "$PLUGINS/rbenv-communal-gems" "$GH/tpope/rbenv-communal-gems"
  syncConfigRepo "$PLUGINS/rbenv-user-gems"     "$GH/mislav/rbenv-user-gems"
  echo 'Done.'
}

pyenvSetup()
{
  blankLines
  echo 'Installing pyenv...'
  local GH='https://github.com'
  local ROOT="$HOME/.pyenv"
  local PLUGINS="$ROOT/plugins"
  syncConfigRepo "$ROOT"                     "$GH/pyenv/pyenv"
  syncConfigRepo "$PLUGINS/pyenv-doctor"     "$GH/pyenv/pyenv-doctor"
  syncConfigRepo "$PLUGINS/pyenv-installer"  "$GH/pyenv/pyenv-installer"
  syncConfigRepo "$PLUGINS/pyenv-update"     "$GH/pyenv/pyenv-update"
  syncConfigRepo "$PLUGINS/pyenv-virtualenv" "$GH/pyenv/pyenv-virtualenv"
  syncConfigRepo "$PLUGINS/pyenv-which-ext"  "$GH/pyenv/pyenv-which-ext"
  echo 'Done.'
}

nodenvSetup()
{
  blankLines
  echo 'Installing nodenv...'
  local GH='https://github.com'
  local ROOT="$HOME/.nodenv"
  local PLUGINS="$ROOT/plugins"
  syncConfigRepo "$ROOT"                               "$GH/nodenv/nodenv"
  syncConfigRepo "$PLUGINS/node-build"                 "$GH/nodenv/node-build"
  syncConfigRepo "$PLUGINS/nodenv-default-packages"    "$GH/nodenv/nodenv-default-packages"
  syncConfigRepo "$PLUGINS/nodenv-package-json-engine" "$GH/nodenv/nodenv-package-json-engine"
  syncConfigRepo "$PLUGINS/nodenv-package-rehash"      "$GH/nodenv/nodenv-package-rehash"
  syncConfigRepo "$PLUGINS/nodenv-update"              "$GH/nodenv/nodenv-update"
  echo 'Done.'
}

jenvSetup()
{
  blankLines
  echo 'Installing jenv...'
  syncConfigRepo ~/.jenv https://github.com/gcuisinier/jenv
  echo 'Done.'
}

utilSetup()
{
  blankLines
  printf 'Installing handy configs and wrappers... '
  backupThenSymlink "$config_dir/proxychains/proxychains.conf" ~/.config/proxychains.conf
  backupThenSymlink "$util_dir/shell/pyenv-install" ~/bin/pyenv-install
  backupThenSymlink "$util_dir/spark/pyspark-jupyter" ~/bin/pyspark-jupyter
  backupThenSymlink "$util_dir/spark/pyspark-jupyter-public" ~/bin/pyspark-jupyter-public
  echo 'Done.'
}

envSetup()
{
  gitSetup
  rbenvSetup
  pyenvSetup
  nodenvSetup
  jenvSetup
  tmuxSetup
  tigSetup
  vimSetup
  sshSetup
  zgenSetup
  utilSetup

  installCommonPackages
}

basicSetup()
{
  gitSetup
  tmuxSetup
  tigSetup
  vimSetup
  sshSetup
  zgenSetup
}
