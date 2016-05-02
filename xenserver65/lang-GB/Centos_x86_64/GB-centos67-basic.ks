# Build a basic CentOS 67 Image with DHCP Networking
# Use this Mirror (HTTPS fails)) http://mirror.centos.org/centos/6.7/os/x86_64/
# Use these boot parameters in Xenserver
# console=hvc0 utf8 nogpt noipv6 ks=http://kickstarts.systemhosted.com/xenserver-anaconda-kickstarts/xenserver65/lang-GB/Centos_x86_64/Centos6_7/centos67.ks

# Language, Timezone,and keyboard setup
lang en_GB.UTF-8
timezone --utc Europe/London
keyboard GB

# Disable anything graphical
skipx
text

auth --useshadow --enablemd5
selinux --permissive
bootloader --timeout=1 


#Networking
# for STATIC IP: uncomment and configure network --onboot=yes 
# --device=eth0 --bootproto=static --ip=192.168.###.### 
# --netmask=255.255.255.0 --gateway=192.168.###.### 
# --nameserver=###.###.###.### --noipv6 --hostname=$$$ for DHCP 


network --bootproto=dhcp --device=eth0 --onboot=on
services --enabled=network
firewall --enabled --ssh


#DRIVES
zerombr
clearpart --all 
part / --grow --size 1 --fstype ext4


rootpw qwertyuiop12345
# if you want to preset the root password in a public kickstart file, 
# use SHA512crypt e.g. rootpw --iscrypted 
# $6$9dC4m770Q1o$FCOvPxuqc1B22HM21M5WuUfhkiQntzMuAV7MY0qfVcvhwNQ2L86PcnDWfjDd12IFxWtRiTuvO/niB0Q3Xpf2I.


#halt
#poweroff
#shutdown
reboot

# Repositories
repo --name=CentOS6-Base --baseurl=http://mirror.centos.org/centos/6.7/os/x86_64/
repo --name=CentOS6-Updates --baseurl=http://mirror.centos.org/centos/6.7/updates/x86_64/

# Add all the packages after the base packages
#
%packages --nobase --instLangs=en --excludedocs
@core
system-config-securitylevel-tui
system-config-firewall-base
audit
pciutils
bash
coreutils
kernel
grub
e2fsprogs
passwd
policycoreutils
chkconfig
rootfiles
yum
vim-minimal
nano
acpid
openssh-clients
openssh-server
curl

#Allow for dhcp access
dhclient
iputils

#stuff we really done want
-kernel-firmware
-xorg-x11-drv-ati-firmware
-iwl6000g2a-firmware
-aic94xx-firmware
-iwl6000-firmware
-iwl100-firmware
-ql2200-firmware
-libertas-usb8388-firmware
-ipw2100-firmware
-atmel-firmware
-iwl3945-firmware
-ql2500-firmware
-rt61pci-firmware
-ipw2200-firmware
-iwl6050-firmware
-iwl1000-firmware
-bfa-firmware
-iwl5150-firmware
-iwl5000-firmware
-ql2400-firmware
-rt73usb-firmware
-ql23xx-firmware
-iwl4965-firmware
-ql2100-firmware
-ivtv-firmware
-zd1211-firmware

%end

#
# Add custom post scripts after the base post.
#
%post
yum update all
%end

