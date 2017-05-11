---
layout: post
title: Raid Set 1 Degraded
author: Wook
date: 2017-05-10
tags: 
 - Computers
---

My MacPro has an Apple raid card in it, because I hate having 4 separate disk drives
in a computer.  The raid card makes 4 drives look like one big one.  The card also
protects when one drive fails.  Which seems to be what happened just now:

![events](/pics/raid-events.png)

The drive in Bay 2 just vanished while in use.  Because I have raid 5, the computer
is still functional, and I have access to all my data.  But access will be slow, as
the raid card has to calculate what was on the missing drive from info on the 3 still
working.  Also, if one more drive fails, I lose the whole machine.

The problem might just have been utilization.  I had a Win10 VM cleaning up its disk space,
Lightroom loading a large, 17,000+ photo catalog, iTunes playing, iDrive downloading
a few gigabytes of photos.  Disturbingly, the VM and Lightroom seemed to hang, which
is not supposed to happen on a raid protected system when a disk fails.

This computer is a "Mid 2010" MacPro, purchased in early 2011.  It's kind of amazing
that this 6-year-old computer and its equally old spinning hard drives haven't thrown
so much as a hiccup before now.  In my experience, hard drives last 3 years.

There are 3 possibilities, as I see it:

1. The bay 2 drive is really failing.
1. Drives are getting old, just too much work for too long, could have happened
to any of the 4 drives in the machine.
1. Power supply weakness, could have been kernel panic just as much as hard drive
failure.

Powering down and powering up the machine brought the drive back.  I made it a
spare, and the raid card slurped it into the raid set and is now rebuilding.

![rebuild](/pics/raid-rebuild.png)

I expect that to take a day or two, if I remember correctly from when
I first set it up 6 years ago.

I have a plan to replace all the spinning drives with SSDs, but that plan really
can't happen now.  I can buy a replacement hard drive of the same model number for
about $60, and that'll be an option if the rebuild doesn't finish.  Might need to
do it anyway, since drives in a raid array like this tend to crap out all at the
same time.

I might order one Hitachi HDS722020ALA330, and if it works with the raid card (it
might not, this raid card is the worse one ever made and might be really picky)
I'll get 3 more and replace them all one at a time.  Maybe.
