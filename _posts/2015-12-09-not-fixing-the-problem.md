---
layout: post
title: Not Fixing The Problem But Still Paying Less
author: Wook
tags:
 - MacOS Networking
 - Mac OS 10.11
 - Internet
 - Cable Modems
 - Routers
 - Home Networking
---
The problem I have with network packet loss and resets didn't in fact get fixed by
the TWC internet speed reduction I [talked about previously][].  However, the real
opportunity of way faster speeds from our ISPs, is being able to drop down from the
top speed tiers and save some money.

Anyway...

I'm still having the network packet loss, retransmits, and general network protocol
ugliness I've had since upgrading to El Capitan a while back.

I found some talk about MacOS doing ARP cache validation rather aggressively, in a way
that doesn't jive with how router and switch manufacturers think it should be done.
Windows doesn't do ARP cache validation, as far as I can tell.  Linux does it, but not
until the ARP cache tables in the kernel get full.

There is a [post at MacStadium about the issue][].  That post references an [Apple
discussion thread][].  And from there you can get a "[patch][]", which isn't an actual patch,
but is just a configuration change made sorta permanent.  Notably, it didn't fix the
problem.

I've done all that, and while it might have made things better, it didn't fix them.  At
least not completely:

--- 166.84.1.1 ping statistics ---
2025 packets transmitted, 2015 packets received, 0.5% packet loss
round-trip min/avg/max/stddev = 31.179/44.917/66.868/2.885 ms

A half-percent packet loss isn't bad, but until El Capitan, my packet loss was zero.

I've replaced everything except the computer at this point.  I replaced the old SB6141
cable modem with a SB6183, capable of 300Mbps throughput.  I have switched to a Cisco
RV325 router.  I justified that one because it has 14 GigE switch ports
on it, so I could lose the 10/100 switch I was using because I have too much crap on my
desk that I want to plug in.  With that setup, the Airport Extreme is no longer in the
network path from internet to this computer, it is no longer routing or doing NAT,
it is in bridge mode.  All the cables have replaced with Cat6 cables.  (More on this
hardware in another post.)

I still have the problem.

I've
re-loaded MacOS.  I had to do that anyway.  This machine has been upgraded thru every
release since Lion,
which it came with in 2011, all the way thru El Capitan, and it had some strange
behavior.  I also wanted to change the partitioning of the raid array, which can't
be done with Apple hardware without reloading.  So I reloaded.

I've also checked as best I can, and none of the other computers have this issue, so
it kind of has to be the MacPro or Time Warner.  I can't check the other two Macs, because the old
MacPro died recently, and the MacBookPro doesn't have a ethernet port on it, and I didn't
have a Thunderbolt to GigE adapter until very recently.  And I keep forgetting to take
it out and check.  I didn't see it happening to my work laptop tho, for what that's
worth.

[post at MacStadium about the issue]: http://www.macstadium.com/blog/osx-10-9-mavericks-bugs/
[Apple discussion thread]: https://discussions.apple.com/thread/5483424?start=45&tstart=0
[patch]: https://github.com/MacMiniVault/Mac-Scripts/blob/master/unicastarp/unicastarp-README.md
[talked about previously]: {% post_url 2015-11-12-cable-speed-problem %}