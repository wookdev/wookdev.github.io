---
layout: post
author: Wook
title: A Grand New Plan
tags:
- Raspberry Pi
- Kubernetes
- ISCSI
- Dreams
date: 2021-02-17 00:00:00 -0500

---
My interest is starting to fade in the games I've been playing for the last few years. [Factorio](https://www.factorio.com "Factorio Site") and [Elite Dangerous](https://www.elitedangerous.com "Elite Dangerous") mostly.  I've tried a couple of new ones recently, but none kept me busy for more than a week or two.

There's a titanic shift going on about how IT constructs and delivers Internet services.  Since my career stubbornly refused to channel me into those new things, I figure to do it myself, here on my desk.

Thus, a Grand Plan has been hatched.

## Highest Level Goals

Here's the 10K foot view:

* Raspberry Pi cluster
* Kubernetes
* NAS for Storage

That's really it.  

I want a little more involvement than Docker Desktop's single-host Kubernetes.  See below for the concerns around how many PIs is the optimal number.

Kubernetes is the newest thing.  Might as well learn it as much as possible.  One big question here is that there are several ways of doing this.  Straight up Google Kubernetes, Canonical's microK8S clusters, probably others.

I recently bought a fancy new iXSystems TrueNAS server.  I'd like to use it for all storage for this project.  Because why else did I buy it.

But since I can't leave things there, we have:

## High Level Level Goals

The 1K foot view:

* Network Boot the Pi cluster
* POE Power the Pi cluster
* Automate RPi node creation and configuration
* Helm, Rancher, and other tools like them

Pis normally use microSD cards for storage, and boot from them.  SD cards wear out over time as they are written to.  SD cards aren't appropriate storage for what I want to do with them.  One thing I don't want to do with them is somehow keep track of a bunch of microSD cards.  They are really small.

Since, as I'll get to below, the optimal number of Pis is probably 24, I can't have 24 power bricks plugged in here.  The other option is an industrial power supply of some kind, powering the Pis from GPIO pins.  I don't know enough about this, so instead I'll go with POE to power them from the network switch I need for them anyway.

I don't want to configure the hardware myself.  Everything will be scripted and I'll explore automation tools for managing them.  I already know Ansible.  I'll explore other tools too.

K8S iteslf is a beast.  Installing I'll automate as much as possible, but it's kinda of a one-time thing, I suspect.  For actually putting containers on it tho, I'll explore Helm and Rancher if I can, two tools to manage the cluster itself.

## Mid Level Goals

The 10-foot veiw:

* K8S [CSI](https://kubernetes.io/blog/2019/01/15/container-storage-interface-ga/) for TrueNAS
* Base CNI working with haproxy

Since I'm using my NAS for all storage, I need to make sure K8S can use it too, which means a Container Storage Interface for TrueNAS.

You have to get network traffic from The World into the cluster.  I've heard of a couple of CNIs that don't assume load balancers. Flannel and something else.  I've used haproxy before tho, and it seems perfect for this.

## Low Level Goals

The real thing, going on here:

* I have 4 Raspberry Pi 4B boards, with POE HATs.

These were hard to figure out where to buy.  A lot of places only allow 1 or two per household, and the POE HATs were sold out.  Until I looked at electronics suppliers, which are listed on the Raspberry Pi Foundations web site.  These suppliers often have a couple thousand on hand, both the Pis and the POE HATs too.  So I have 4 Pi 4B and the POE HATs to go on them.

## How Many is Too Many

For starters, I was just going to do 4 RPis in a cluster.  Seemed like a good number, and I was thinking of getting a [TuringPi v2](https://turingpi.com/v2/) setup to do this.  By the time those were available, I'd already purchased my 4.  And now that I have them, I kind of like the flexibility of having the real 4B boards.

But is 4 really the right number?  The requirements are:

1. The Pis need 1Gig switch ports with 15 watts POE
2. I want 1 Pi per 1G port on the switch
3. I want a 10Gig switch port for the NAS
4. An extra 1Gig port for the uplink to the UDM
5. POE ports for the Pis, at 15W per port

Switch ports seem to come in groups of 8, with some extra ports sometimes.  For example, [this Netgear switch](https://www.amazon.com/NETGEAR-Ethernet-Unmanaged-Multi-Gig-Protection/dp/B076642YPN) would be perfect, except for the lack of POE.  It has 8 1Gig ports, and 2 10Gig ports.  This is 8 Pis, one NAS, and 1 uplink.

Most, if not all other 8+ port switches I've found are limited to only 1Gig ports on SFP cages.  To get 10Gig SFP+ cages, usually takes 16+ port switches.

So maybe I need 16 ports and 16 RPis...

There are lots of 16 port switches that have POE, that can't push 15 watts out all the 1Gig ports.  They'll have 8 POE ports, but a "power budget" of 60, or 90 or 100 watts.  8 Pis need 120 watts all told, 16 need 240 watts.  There are some that can do this, but they are rare.

Then I stumbled across [this MicroTik switch](https://mikrotik.com/product/crs328_24p_4s_rm).  24 ports backed by a 500 watt power supply, with 4 SFP+ cages, all for less than 400 bux.

If I'm allowing myself to be obsessive about this, I then need 24 RPis with POE HATs, 2 12xRPi rack mount kits, that 24 port POE swtich, and a rack to mount them to that'll sit on my desk.