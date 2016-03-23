#!/bin/bash

# you should use " bash root_install.sh " to run this script

sudo chmod u+x $0

if [ ! -n "$ROOTSYS" ]
then

echo ""
echo "   _____________________________________________________________________________________________________________"
echo "  >>-----------------------------------------------------------------------------------------------------------<<"
echo "  >>      This scprit is to install ROOT automatically. It is not perfect,just for EXTREMELY LAZY person !!!!! <<"
echo "  >>                   Please contact me if you have any problems                                              <<" 
echo "  >>        Author: Lee  (leeyeel@impcas.ac.cn) 2016/03/22                                                     <<"      
echo "  >>-----------------------------------------------------------------------------------------------------------<<"
echo ""
echo -e " Select ROOT Version You Want.The Default Version Is: \033[31m root_v5.34.34\033[0m"
echo -e " For example,you should type \033[41;37m root_v6.06.02\033[0m if you want to install root_v6.06.02"

read -t 100 -p "Type ROOT Version You Want : " version
echo ""
version=${version:=root_v5.34.34}
echo  " You selected Version Is:" $version

release_1=$(lsb_release -a |grep Description |grep -i -e Ubuntu -e debian)
release_2=$(lsb_release -a |grep Description |grep -i -e Fedora -e Scientific -e CentOS -e RedHat)
release_3=$(lsb_release -a |grep Description |grep -i -e openSUSE)
if [ -n "release_1" ]
  then
  echo -e "\nYour linux $release_1\n"
  alias INSTALL="sudo apt-get install "
  flag=1
elif [ -n "release_2" ]
  then 
  echo -e "\nYour linux $release_2\n"
  alias INSTALL="sudo yum install "
  flag=2
elif [ -n "release_3" ]
  then
  echo -e "\nYour linux $release_3\n"
  alias INSTALL="sudo zypper install"
  flag=3

fi

 
echo -e "\nInstall Required packages: ..... \n"
if [ $flag -eq 1 ];then
INSTALL -y git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev  >>apt_get.log 2>&1
elif [ $flag -eq 2 ];then
INSTALL git make gcc-c++ gcc binutils libX11-devel libXpm-devel libXft-devel libXext-devel >>yum.log 2>&1
elif [ $flag -eq 3 ];then
INSTALL git bash make gcc-c++ gcc binutils xorg-x11-libX11-devel xorg-x11-libXpm-devel xorg-x11-devel xorg-x11-proto-devel xorg-x11-libXext-devel >>zypper_get.log 2>&1
fi

echo -e "\n Install Optional packages: .....\n "

if [ $flag -eq 1 ];then
INSTALL -y gfortran libssl-dev libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev libfftw3-dev cfitsio-dev graphviz-dev libavahi-compat-libdnssd-dev libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev wget >>apt_get.log 2>&1

elif [ $flag -eq 2 ];then
INSTALL wget gcc-gfortran openssl-devel pcre-devel mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel fftw-devel cfitsio-devel graphviz-devel avahi-compat-libdns_sd-devel libldap-dev python-devel libxml2-devel gsl-static >>yum.log 2>&1

elif [ $flag -eq 3 ];then
INSTALL wget gcc-fortran libopenssl-devel pcre-devel Mesa glew-devel pkg-config libmysqlclient-devel fftw3-devel libcfitsio-devel graphviz-devel libdns_sd avahi-compat-mDNSResponder-devel openldap2-devel python-devel libxml2-devel krb5-devel gsl-devel libqt4-develi >>zypper_get.log 2>&1
fi


echo -e "\n Downloading ROOT Release $version...."
wget  https://root.cern.ch/download/${version}.source.tar.gz $HOME 
cd $HOME
tar xvzf ${version}.source.tar.gz

cd root*
./configure --all
make -j4
sudo make install

echo -e "#ROOT \n source $HOME/root/bin/thisroot.sh">>$HOME/.bashrc
source $HOME/.bashrc

fi

echo -e "\033[31m YOU HAVE INTSTALLED A ROOT IN YOUR COMPUTER  \033[0m"
sleep 5
root 
