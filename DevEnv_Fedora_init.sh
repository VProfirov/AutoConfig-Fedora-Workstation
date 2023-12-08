#!/usr/bin/env bash
#
# NOTE: THIS IS THE 2nd part of the fedora_init track aimed at setuping for Software Developers and DevOps
#
package_manager=dnf
if [[ -n $(rpm -q dnf5) ]];then
  package_manager=dnf5;
else
  sudo dnf install dnf5 -y
  if [[ -n $(rpm -q dnf5) ]];then
  package_manager=dnf5;
  fi
fi
# NOTE: DEBUG v1 -> ProblemCase: if dnf5 is already installed it won't assign it as a package_manager
# if [[ -z $(rpm -q dnf5) ]]; then
#   sudo dnf install dnf5 -y;
#   if [[ -n $(rpm -q dnf5) ]];then
#     package_manager=dnf5;
#   fi
# fi

## -->
echo '==> Dependency checker & intall:'
c_commpiler_depndencies="gcc "
cpp_compiler_dependencies="gcc-c++"
rust_compiler_dependencies="rust cargo"
python_compiler_dependencies="python3 python3-pip"
golang_compiler_dependencies="golang"
nodejs_compiler_dependencies="nodejs"
dotnet_compiler_dependencies="dotnet"
compiler_dependencies=($c_commpiler_depndencies $cpp_compiler_dependencies $python_compiler_dependencies $rust_compiler_dependencies)
# --> TODO:(1): repo-checker + if [[!-z]] repo-install
echo "==> $compiler_dependencies"
# TODO:(1) Expression spreading the compiler_dependencies into -> rpm -qa | grep -iE "(xargs $compiler_dependencies "|")"
for dep in "${compiler_dependencies[@]}";do
    if [[ -z $(rpm -q $dep) ]] ; then 
      sudo $package_manager install -y $dep;
    fi
done
# --> TODO:(2): check & add prog_langs to PATH
# --> TODO:(3): env-s setups (ref. golang $HOME/go_dir/go_bin --> run go apps from (./app))

# -> Program Languages dependent Apps
echo '==> Installing LVIM'
LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
## -->
echo '==> The SoftDev Stack:'

echo '==> Install using Flatpak:'
echo '==> installing GitKraken'
flatpak install -y com.axosoft.GitKraken \

echo '==> installing jetbrains-toolbox'
if [[ ! -e jetbrains-toolbox-*.tar.gz ]];then
  curl https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.0.2.16660.tar.gz --remote-name --output /home/$USER/Downloads/
fi

echo '==> Installing external Packages:'
echo '==> installing JetBrains Tools (IDEs)'
if [[ ! -e /opt/jetbrains ]];then
  sudo mkdir -p /opt/jetbrains
  sudo tar -xzf /home/$USER/Downloads/jetbrains-toolbox-2.0.2.16660.tar.gz -C /opt/jetbrains
fi
echo '==> NOTE: Search for the JetBrains Toolbox and manually install the apps needed (Rider for dotNet, Pycharm for Python, etc...)!'


## -->
echo '==> The DevOps stack:'

echo '==> installing the virtualization toolsets:'
echo '==> VirtualBox, VirtualBox-guest-additions, akmods-VirtualBox'
virtualbox_dependencies="VirtualBox virtualbox-guest-additions akmod-VirtualBox"
for dep in "${virtualbox_dependencies[@]}";do
  if [[ -z rpm -q $dep ]];then
    sudo $package_manager install -y $dep
  fi
done

echo '==> installing containerization toolsets:'
# --> Since this is a Workstation (Fedora) we will use the "moby-engine"
echo '==> Installing the "moby-engine"'
containerization_dependencies="moby-engine"
for dep in $containerization_dependencies;do
  if [[ -z rpm -q $dep ]];then
    sudo $package_manager install -y $dep
  fi
done

echo '==> Podman (demonless alternative to Docker)'
# --> Podman comes out of the box for Fedora 35+.
# --> If it is not we install it as it doesn't cause dependency conflicts with the moby-engine (unlike the docker-ce)

if [[ -z rpm -qa | grep -iE podman ]];then
  sudo $package_manager install -y podman
fi
# NOTE: for the Staging Environments we will install docker-ce, etc...
# TODO: test if the moby-engine contradicts with the docker-ce
