---
layout: post
author: Wook
title: Network Booting Raspberry Pi 4B Running Ubuntu with an ISCSI Root
tags:
- Raspberry Pi
- Network Boot
- Ubuntu
- Ubuntu 20.04
- TrueNAS
date: 2021-02-26 00:00:00 -0500

---
I'm running a small cluster of Raspberry Pi 4B 8Gig Boards, and want to run Ubuntu server on them, boot them from the network, and have them use ISCSI for the root device.  This is because I don't need to deal with SD cards wearing out.  And also because it is just cool.

# What We're Doing Here

1. The RPi will boot via tftp to initialize itself
2. The RPi bootloader will load the linux kernel and initramfs directly
3. An iSCSI devices on my TrueNAS server will be the root device
4. An NFS mount will be the /boot/firmware directory

The RPi is not actually a PXE device.  It will not pick up the tftp server or the 2nd stage boot loader from DHCP.  The tftp server has to be configured in the Pi's OTP.  We will only use DHCP to set the IP addresses, which will be static.

Ubuntu on the Pi includes a 2nd stage bootloader called uBoot.  This is a bootloader intended for embedded application.  It _IS_ a PXE client.  It can also load a compressed kernel, which the Pi itself can't do.  As configured out of the box, it doesn't understand how to load files from tftp using the tftp prefix like the Pi's bootloader does, which is a big enough change that we decided to bail on uBoot.  We'll come back to it later.

# TFTP, NFS, and iSCSI Setup

On the TrueNAS server, we'll configure a tftp server and also share the tftp directory via NFS.  This is so that the files that the Pi loads during network booting are the same files available in the /boot/firmware directory once it's running.

The Pis will be configured with TFTP_PREFIX=2, so that all get requests to the tftp server will have the Pi's MAC address as a directory prefix.  The MAC address needs to be of the form `dc-a6-32-e9-00-4c`, with the normal colons replaced by dashes.

## tftp

On the TrueNAS server, edit the tftp service configuration to look like this:

![](/pics/screen-shot-2021-02-26-at-12-18-02-am.png)

Setting the username for the service to root is important.  All the files served by the tftp server come from the /boot/firmware directory, and are all owned by root.  This normally wouldn't matter, but we'll be mounting the tftp directory via NFS, where file ownership matters.

Make sure the tftp service is running, and set to start at system boot.

## NFS

Make sure the NFS service is running, and it set to start at system boot.  It does not otherwise need to be edited.

Then move to Sharing --> Unix Shares (NFS), and create a new share. Configure it like thus:

![](/pics/screen-shot-2021-02-26-at-12-26-39-am.png)

Path must be the same as the tftp service path.

Make sure "All dirs" is checked.  This is important so that subdirectories of tftp can be mounted directly.

Because the files we're dealing with here are owned by root, and will be updated by root, it is also important that the maproot user and group are set to "root" and "wheel" respectively.

I've set up authorized networks, but this isn't required or even important.

## iSCSI