#!/usr/bin/env bash

echo '==> Distro Sync'
sudo dnf distro-sync -y


echo '==> Calling the Basic initial administration script (AdminTools-Fedora-init.sh)'
sudo bash ./AdminTools-Fedora-init.sh

echo '==> Calling the Default Development Environment init script(DevEnv_Fedora_init.sh)'
sudo bash ./DevEnv_Fedora_init.sh