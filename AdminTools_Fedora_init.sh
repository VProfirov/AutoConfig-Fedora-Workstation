#!/usr/bin/env bash

echo '==> Adding generic applications (zsh, fzf...)'
# TODO:1: rpm-package checker logic (so it doesn't blow out)
	# NOTE: example: if dnf list $package | grep -iE "available"; then dnf install $package;fi
# TODO:2: group the package is common groups --> ex: terminal-related(terminator, grc, bat, zsh...); system-analytics (inxi, nvtop, btop); educational (tldr, cheat, fun(curl cht.sh/$subject)...)
sudo dnf install -y dnf5 zsh terminator fzf hstr grc vim neovim vim-X11 bat tldr cheat btop bashtop keepassxc fd-find exa duf ncdu inxi


echo "==> System's Hardware Status:"
inxi -Fxz

# NOTE: external installs path(~/Downloads) : vivaldi, etc..

echo '==> Adding external applications like Vivaldi'
if [[ ! -d "/home/$USER/Downloads" ]];then
	mkdir -p "/home/$USER/Downloads"
fi

# TODO:3: redo if logics in the entire script
USER_Downloads="/home/$USER/Downloads"
cd $USER_Downloads || mkdir -p $USER_Downloads && cd $USER_Downloads || exit
# NOTE: "brackets [[]] and globing"
if [[ ! -e  "/home/$USER/Downloads/vivaldi-stable-*.x86_64.rpm" ]];then
  curl "https://downloads.vivaldi.com/stable/vivaldi-stable-6.1.3035.302-1.x86_64.rpm" --remote-name --output "/home/$USER/Downloads"
fi

sudo dnf5 install -y vivaldi-stable-6.1.3035.302-1.x86_64.rpm
sudo dnf5 upgrade -y vivaldi-stable

echo '==> Adding "KDE Plasma Workspaces"'
sudo dnf group install -y "KDE Plasma Workspaces"

echo '==> Adding Fusion repos'
sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

echo '==> Adding flahub remote repo to flatpak. However Fedora flatpak repo will be prio during installation of flatpaks'
flatpak remote-add --if-not-exists flathub "https://flathub.org/repo/flathub.flatpakrepo"

echo '==> Adding 'Flatseal' - flatpak control center'
flatpak install -y com.github.tchx84.Flatseal

echo '==> Adding Communication and Productivity apps (flatpak)'
flatpak install -y com.discordapp.Discord \
com.github.alainm23.planner \
com.calibre_ebook.calibre \
io.github.peazip.PeaZip \
com.wps.Office \
org.videolan.VLC \
org.clementine_player.Clementine \

echo '==> Win-Wine type containers for linux'
flatpak install -y com.usebottles.bottles

echo '==> Configuring zsh and plugins'

echo '==> oh-my-zsh install'
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo '==> zsh themes install'
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

omz reload

echo '==> zplug install'
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh\

# TODO:4: NeoVim: is not configured

# TODO:5: REDO THE *rc-s (zshrc especially)
	# NOTE:1: add *rc and *_history sync (for zsh and bash)
	# NOTE:2: trim to the latest versions only and publish it in the relative GitHub repo
	# NOTE:3: improve the *rc-s dev-env calls. Trim description info or have a README-Shadow.md (The scripts with the comments while the script itself has none or minimal, short, one-liners). Use the README-Shadow.md as *rc staging script file that is then trimmed out of the expansive, lengthy comments. (It is just an idea)

# TODO:6: add fedora/kernel(ex:6.0.4) specific solutions to applications used, like "hstr"  for example (fuzzy history search and use) bug with the hist-entry selection and use.
	# NOTE: --> namely the tty_legacy_tiocsti.service I made a while back (has a secutiy draw back that was intended to be resolved by the 6.0.+ kernel but is needed by the "hstr" app)

# TODO:7 (->7.1): COMPLICATED: REDEFINE THE TODO: GUI SOLUTION IS through the gnom GUI. Configure the X11 Display server to use the Nvidia GPU on KDE using the fallowing config file: /etc/X11/xorg.conf.d/nvidia.conf
	# NOTE:1: This is after installing the nvidia kernel modules and the "Nvidia X Server Settings" app. Some other Nvidia stats apps require the nvidia-drm and nvidia-smi
	# NOTE:2: That can be done by installing the xorg-x11-drv-nvidia-cuda by default only the cuda-libs are installed with the GNOME's Software GUI Packagage manager - "NVIDIA Linux Graphics driver" (last version used for installation 535.98).
  	# NOTE: Installed from the rpmfusion-nonfree-nvidia-driver.rpm
  # TODO:7.1: Investigate the rpmfusion-nonfree-nvidia-driver and what does it install under the "NVIDIA Linux Graphics Driver" package (? Is it the akmod-nvidia and the xorg-x11-drv-nvidia ?)
	# NOTE:0: Seems that Vivaldi have fixed the Nvidia GPU use in KDE
	# NOTE:1: When it comes to the browser KDE doesn't use NVIDIA on the Acer for the moment for some reason but uses the CPU ==> check after restart with YT Tokyo HD
	# NOTE:2: When it comes to the browser - Check if the GNOME also doesn't use the GPU