# Night-Owl

![alt text](https://github.com/roaldi/Night-Owl/blob/main/Assets/Pictures/Night%20Owl.jpeg)

A simple network sensor designed to be lightweight and easy to use.

Components:
Snort3 - Signature based events
Zeek - Network Metadata
Stenographer - Full PCAP capture

How to install:

```git clone https://github.com/roaldi/Night-Owl```

```cd Night-Owl/Build/<OS>```

```sudo ./ build.sh```

This will install snort, zeek, and stenographer. Additionally, it will download and use PulledPork to download and load community rules by default. 
After install and reboot, hoot.sh is used to do any post install configuration <WIP>
