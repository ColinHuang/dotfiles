#!/bin/bash

sudo apt-get -y install zsh git-core tree curl ctags silversearcher-ag htop autojump g++ exuberant-ctags \
      cscope indent cppcheck build-essential fakeroot tig highlight jq lrzsz
sudo wget https://github.com/aykamko/tag/releases/download/v1.4.0/tag_linux_amd64.tar.gz -O - | tar -xz -C /bin/

