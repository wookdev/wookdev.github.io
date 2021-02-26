---
layout: post
author: Wook
title: 24 Slices of RPi
tags:
- Raspberry Pis
date: 2021-02-26 00:00:00 -0500

---
For starters, I was just going to do 4 RPis in a cluster.  Seemed like a good number, and I was thinking of getting a [TuringPi v2](https://turingpi.com/v2/) setup to do this.  By the time those were available, I'd already purchased my 4 Raspberry Pi 4B boards.  And now that I have them, I kind of like the flexibility of having the real 4B boards.

But is 4 really the right number?  The requirements are:

1. The Pis need 1Gig switch ports with 15 watts POE
2. I want 1 Pi per 1G port on the switch
3. I want a 10Gig switch port for the NAS
4. An extra 1Gig port for the uplink to the UDM
5. POE ports for the Pis, at 15W per port

Switch ports seem to come in groups of 8, with some extra ports sometimes.  For example, [this Netgear switch](https://www.amazon.com/NETGEAR-Ethernet-Unmanaged-Multi-Gig-Protection/dp/B076642YPN) would be perfect, except for the lack of POE.  It has 8 1Gig ports, and 2 10Gig ports.  This is 8 Pis, one NAS, and 1 uplink.

Most, if not all other 8+ port switches I've found are limited to only 1Gig ports on SFP cages.  To get 10Gig SFP+ cages, usually takes 16+ port switches.

So maybe I need 16 ports and 16 RPis...

There are lots of 16 port switches that have POE, that can't push 15 watts out all the 1Gig ports.  They'll have 8 POE ports, but a "power budget" of 60, or 90 or 100 watts.  8 Pis need 120 watts all told, 16 need 240 watts.  There are some that can do this, but they are rare and expensive.

Then I stumbled across [this MicroTik switch](https://mikrotik.com/product/crs328_24p_4s_rm).  24 ports backed by a 500 watt power supply, with 4 SFP+ cages, all for less than 400 bux.

If I'm allowing myself to be obsessive about this, I then need 24 RPis with POE HATs, 2 12xRPi rack mount kits, that 24 port POE swtich, and a rack to mount them to that'll sit on my desk.

No, the Pis probably don't need a whole 15 watts of power each.  I'd guess that is their theoretical maximum power draw based on HATs, connected USB devices, etc.