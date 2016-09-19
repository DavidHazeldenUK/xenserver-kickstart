xenserver-kickstart
===================

Kickstart scripts for unattended installation of linux guests with Xenserver for distributions that use Anaconda

Going to need an active Internet Connection and DHCP for providing IP address to booting VPS

1.) Open XenCenter >>> Select Node to Create VPS

2.) Right Click >>> New VM

3.) Select Template for Linux Distribution

4.) Name It

5.) Select Installation Media, You can do it via URL or ISO

6.) Add Raw Github url to Advanced OS Boot Parameters, Kickstarts don't always like HTTPS, and you can't access Github at http.

CENTOS6##########

console=hvc0 utf8 nogpt noipv6 ks=http://kickstarts.systemhosted.com/xenserver-anaconda-kickstarts/xenserver65/lang-GB/Centos_x86_64/Centos6_8/centos68.ks

console=hvc0 utf8 nogpt noipv6 ks=http://kickstarts.systemhosted.com/xenserver-anaconda-kickstarts/xenserver65/lang-GB/Centos_x86_64/GB-centos70-basic.ks

CENTOS7##########

console=hvc0 utf8 nogpt noipv6 ks=http://kickstarts.systemhosted.com/xenserver-anaconda-kickstarts/xenserver65/lang-GB/Centos_x86_64/GB-centos70-basic.ks

7.) Specificy VPS Location on which NODE, Appropriate CPU, Memory, Network Adapter

8.) Click Finish and Monitor Build from Console
