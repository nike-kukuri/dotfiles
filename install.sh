#!/bin/bash

set -u

# 実行場所のディレクトリを取得
CURRENT_DIR=$(cd $(dirname $0); pwd)

cd $CURRENT_DIR
git submodule init
git submodule update

echo "start setup..."
for f in .??*; do
  [ "$f" = ".git" ] && continue
  [ "$f" = ".gitconfig.local.template" ] && continue
  [ "$f" = ".require_oh-my-zsh" ] && continue
  [ "$f" = ".gitmodules" ] && continue

  ln -snfv ~/dotfiles/"$f" ~/
done

[ -e ~/.gitconfig.local ] || cp ~/dotfiles/.gitconfig.local.template ~/.gitconfig.local

# emacs setup
if which cask >/dev/null 2>&1; then
  echo "setup .emacs.d..."
  cd ${CURRENT_DIR}/.emacs.d
  cask upgrade
  cask install
fi

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
