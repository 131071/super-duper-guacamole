#!/bin/bash

set -e

export RVM_PATH="~/.rvm/scripts/rvm" 

echo "Adding PPA for Node.js runtime."
add-apt-repository ppa:chris-lea/node.js

echo "Updates packages."
apt-get update

echo "Installs packages."
apt-get --ignore-missing install build-essential git-core curl openssl libssl-dev libcurl4-openssl-dev zlib1g zlib1g-dev libreadline-dev libreadline6 libreadline6-dev libyaml-dev libsqlite3-dev libsqlite3-0 sqlite3 libxml2-dev libxslt1-dev python-software-properties libffi-dev libgdm-dev libncurses5-dev automake autoconf libtool bison postgresql postgresql-contrib libpq-dev pgadmin3 libc6-dev nodejs -y

echo "Installs ImageMagick for image processing"
apt-get install imagemagick --fix-missing

echo "Installs RVM (Ruby Version Manager)"
#gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo "Installs Ruby"
rvm install 2.2.2
rvm use 2.2.2 --default

echo -e "\n- - - - - -\n"
echo -e "Version Check"

echo -n "Should be sqlite 3.8.1 or higher: sqlite "
sqlite3 --version
echo -n "Should be rvm 1.26.11 or higher:         "
rvm --version | sed '/^.*$/N;s/\n//g' | cut -c 1-11
echo -n "Should be ruby 2.2.2:                "
echo -n "Should I update profile with the rvm path?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "export RVM_PATH=\""$RVM_PATH"\"" >> ~/.profile && echo "export PATH=\"\$PATH:\$HOME/.rvm/bin\"" >> ~/.profile; break;;
        No ) echo -n "Not doing that then";;
    esac
done

echo -n "Should I update profile with the rvm path?"
select yn in "Yes" "No"; do
    case $yn in
        No ) echo -n "all good here then"; break;;
        Yes ) echo -n "installing Rails";

		echo "gem: --no-ri --no-rdoc" > ~/.gemrc
		gem install bundler
		gem install rails
		gem install railties


		echo -e "\n- - - - - -\n"
		echo -e "Version Check"



		ruby -v | cut -d " " -f 2
		echo -n "Should be Rails 4.2.1 or higher:         "
		rails -v
		echo -e "\n- - - - - -\n";
    esac
done

echo "Insallation possibly successful"


source ./profile