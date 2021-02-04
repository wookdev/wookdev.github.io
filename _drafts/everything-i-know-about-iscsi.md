---
layout: post
author: Wook
title: Everything I Know About iSCSI
tags:
- Geek Stuff
- Raspberry Pi
- TrueNAS
- iSCSI
- Networking
date: 2021-02-05 00:00:00 -0500

---
I owe myself a post here about my latest obsessive effort.  But for now, just know that I have 4 [Raspberry Pi 4B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/) boards here, and I'm not afraid to use them.

Task 1 is to get them network booting so I don't have to buy stock in an SD card manufacturing company.  Writing to any kind of SD card (microSD in my case) causes wear.  On computers like the Pi, they can fail pretty quickly.  I'm planning on running some serious software on these things, so I need to not have them running off an SD card.

Network booting has been around forever.  Now days we call it "pixie booting", where pixie is spelled "PXE".  PXE is a standard that's about more than network booting, but nobody cares.  Network booting predates it by about 20 years.

Historically, network boots happened from NFS.  I could do NFS, but I have a fancy-smancy TrueNAS server here now, and it does iSCSI.  So I figure I'll go that way since I didn't really know anything about it.

# What is iSCSI Exactly

The iSCSI protocol is just an implementation of the "Small Computer System Interface" over ethernet. Literally "Internet SCSI".  SCSI was a parallel bus designed to attach physical devices.  It was used mostly for disk drives, but early scanners used it too sometimes.

It is a block protocol, same as a physical disk drive.  Devices attached via iSCSI have to have partitions and file systems created in them, just like physical disks.  TrueNAS stores the blocks in either a zfs "zvol", or in a file.

# Terminology

Like everything else, iscsi has it's own terms, because otherwise it would feel like a wimp that can't be obscure to normal people.

**initiator:** The client that initiates a connection.  (See what they did there?)

**portal:**  A server listening on a network for iscsi requests, represented by an IP address and TCP port.  Severs can have one or more portals configured on them. They can be limited to anywhere from one to all network interfaces on the server.  Portals are made up of targets.

**target:**  Represents a SCSI bus, which is a collection of devices all talking on a common connection.  In iscsi, you connect to targets on portals.  A target can have one or more associated extents.

**extent:**  Represents a single disk drive.  Mapped to exactly one volume on the server.

**LUN:** "Logical Unit Number". Every extent on a target has to have a unique identifier, which is the LUN.  A number between 0 and 1023, tho some systems don't like numbers over 255.  Usually start at 0 and go up.

**Target Association:** Sets which extents are connected to which targets.

**IQN:** "iSCSI Qualified Name". It's just names.  RFC-3721 is a standard, uh, suggestion on how these names are formed.

# Portals