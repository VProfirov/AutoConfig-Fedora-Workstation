#!/usr/bin/env bash

echo "This should be init script for Fedora Cloud 39!"


echo "--> basics : .bashrc and aliases"
# should use sudo but the script is executed in privileged (as root)
mv /home/vagrant/.bashrc /home/vagrant/.bashrc.default
ln -s /vagrant/provision/shell-enhance/.bashrc /home/vagrant/

ln -s /vagrant/provision/shell-enhance/{aliases.sh,ps-twtty-7.sh} /etc/profile.d

echo "--> basics: installing grc for the aliases"
rpm -q grc || dnf install -y grc


if dnf list dnf5 | grep -iE "available";then dnf install -y dnf5;fi
# "available" => not installed but can be
# if ! rpm -q dnf5 && dnf list dnf5;then
# 	dnf install -y dnf5;
# fi