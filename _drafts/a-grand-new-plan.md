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

I want a little more involvement than Docker Desktop's single-host Kubernetes.

Thus, a Grand Plan has been hatched.

Here's the 10K foot view:

* Raspberry Pi cluster
* Kubernetes
* NAS for Storage
* Network Boot the Pi cluster
* POE Power the Pi cluster
* Automate RPi node creation and configuration
* Helm, Rancher, and similar
* K8S [CSI](https://kubernetes.io/blog/2019/01/15/container-storage-interface-ga/) for TrueNAS
* Base CNI working with haproxy

Kubernetes is the newest thing.  Might as well learn it as much as possible.  One big question here is that there are several ways of doing this.  Straight up Google Kubernetes, Canonical's microK8S clusters, probably others.

I recently bought a fancy new iXSystems TrueNAS server.  I'd like to use it for all storage for this project.  Because why else did I buy it.

Pis normally use microSD cards for storage, and boot from them.  SD cards wear out over time as they are written to.  SD cards aren't appropriate storage for what I want to do with them.  One thing I don't want to do with them is somehow keep track of a bunch of microSD cards.  They are really small.

Since, as I'll get to below, the optimal number of Pis is probably 24, I can't have 24 power bricks plugged in here.  The other option is an industrial power supply of some kind, powering the Pis from GPIO pins.  I don't know enough about this, so instead I'll go with POE to power them from the network switch I need for them anyway.

I don't want to configure the hardware myself.  Everything will be scripted and I'll explore automation tools for managing them.  I already know Ansible.  I'll explore other tools too.

K8S iteslf is a beast.  Installing I'll automate as much as possible, but it's kinda of a one-time thing, I suspect.  For actually putting containers on it tho, I'll explore Helm and Rancher if I can, two tools to manage the cluster itself.

Since I'm using my NAS for all storage, I need to make sure K8S can use it too, which means a Container Storage Interface for TrueNAS.

You have to get network traffic from The World into the cluster.  I've heard of a couple of CNIs that don't assume load balancers. Flannel and something else.  I've used haproxy before tho, and it seems perfect for this.