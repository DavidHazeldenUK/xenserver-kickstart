# CentOS 7.0 kickstart for XenServer (PVHVM MBR) UK Version
#Boot Parameters Xenserver 6.5 >>> Select Centos 6 not 7
#Install from URL http://mirror.centos.org/centos/7/os/x86_64/
#console=hvc0 utf8 nogpt noipv6 ks=http://kickstarts.systemhosted.com/xenserver-anaconda-kickstarts/xenserver65/lang-GB/Centos_x86_64/GB-centos70-basic.ks
#Tested working May 2016

# Text mode or graphical mode?
text
skipx
eula --agreed

# Install or upgrade?
install

# System authorization information
auth --enableshadow --passalgo=sha512

# SElinux
selinux --enforcing

# Use network installation
url --url="http://mirror.centos.org/centos/7/os/x86_64/"
repo --name=centos-updates --mirrorlist="http://mirrorlist.centos.org/?release=7&arch=x86_64&repo=updates"

# Firewall configuration (open ports --port=7001:udp,4241:tcp)
firewall --enabled --service=ssh

# Run the Setup Agent on first boot (the post section replaces firsboot 
# for non-interactive installations
#firstboot --enable

# Language and keyboard setup
lang en_UK --addsupport=cs_CZ,de_DE,en_US
timezone "Europe/London" --ntpservers="0.uk.pool.ntp.org,1.uk.pool.ntp.org,2.uk.pool.ntp.org,3.uk.pool.ntp.org"
keyboard --vckeymap=UK --xlayouts='UK'

# Install from a friendly mirror and add updates
install

# Network information (DCHP) --ipv6=auto or 
network  --bootproto=dhcp --noipv6 --activate

# Authentication

#rootpw --lock This option will also disable the Root Password screens in both the graphical and text-based manual installation. 

# Root password (use "grub-md5-crypt" to get the crypted version)
# Password is Qwerty1234
rootpw --iscrypted $1$kA8Mm$MFXATNrvySgD98ns2VSSh0 --lock
# Add Wheel User
user --name=xenadmin --password=Qwerty1234 --plaintext --gecos=Xen Admin Wheel --groups=user,wheel
# if you want to preset the user password in a public kickstart file, use SHA512crypt e.g.
authconfig --enableshadow --passalgo=sha512


#/boot partition - recommended size at least 500 MB 
#root partition - recommended size of 10 GB
#/home partition - recommended size at least 1 GB
#swap partition - recommended size at least 1 GB

#Drives
zerombr 
bootloader --location=mbr --boot-drive=xvda
clearpart --all --initlabel --drives=xvda
autopart --type=lvm --fstype=ext4

# Reboot after installation?
reboot 


# Configure networking without IPv6, firewall off

# for STATIC IP uncomment and configure
# network --onboot=yes --device=eth0 --bootproto=static --ip=192.168.###.### --netmask=255.255.255.0 --gateway=192.168.###.### --nameserver=###.###.###.### --noipv6 --hostname=$$$

# for DHCP #not sure you even have to specify a device --device=eth0
network --bootproto=dhcp --onboot=on


# /usr/bin/sh, /usr/bin/bash, and /usr/bin/python
%pre --interpreter=/usr/bin/python
%end                     

# Minimal package set
%packages --nobase --ignoremissing
@core --nodefaults
dhclient
iputils
system-config-securitylevel-tui
system-config-firewall-base
audit
pciutils
bash
coreutils
kernel
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
-aic94xx-firmware*
-alsa-*
-biosdevname
-btrfs-progs*
-dracut-network
-iprutils
-ivtv*
-iwl*firmware
-libertas*
%end

%post --log=rootks-post.log

#Example Mount an NFS share
#mkdir /mnt/temp
#mount -o nolock 10.10.0.2:/usr/new-machines /mnt/temp
#openvt -s -w -- /mnt/temp/runme
#umount /mnt/temp

# since NetworkManager is disabled, need to enable normal networking
chkconfig network on

%end