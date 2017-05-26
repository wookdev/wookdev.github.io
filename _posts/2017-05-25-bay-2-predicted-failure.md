---
layout: post
title: Bay 2 Predicted Failure
author: Wook
date: 2017-05-25
tags: 
 - Computers
---

As [reported previously][], there was some excitement two weeks ago when a disk
drive that's part of the raid cluster in my main computer just vanished under
load.  The raid card did it's thing, and the computer continued to function.
I rebooted, and the disk showed up again, I made it a spare, the raid card grabbed
it for the raid set, and started rebuilding.

All good.

But then the following Monday, the power blipped. The computer is on a UPS and was
still on when I sat down at my desk, but the MacPro had a blank, black, screen,
and a mouse cursor, and nothing else.  Nothing worked to break it loose of that,
so I power cycled it.

Aaaaaaaaaaand, it wouldn't boot.  It would give the startup chord, and then just a
white screen.

If I pulled the raid card, it would boot up on a USB stick.  I could then see all
4 disk drives, but they weren't usable because they were raid disks.

After buying a replacement disk drive for bay 2 that showed up DOA, and another
raid card that is still in the machine as I'm typing this, I determined it wasn't
the raid card.

Somehow, the raid set was borked.  The Teeming Millions general opinion of the
Apple Raid Card is pretty low, but I figured it's whole reason to exist was to
not let the whole raid set get borked, no matter what happened.  Naive, I know.

What fixed it was this:

- Pull raid card again
- Boot from USB stick with MacOS Installer on it
- Start disk util
- Erase all 4 now non-raid disks
- Put raid card back in
- Boot from USB stick with MacOS Installer on it
- Use disk util to get to raid util, and re-create the raid set
- Install MacOS Sierra on raid set
- Restore from Time Machine backup

This all worked.  Restoring from a [Time Machine][] backup is about as painless
as a backup could ever be.  I lost all my virtual machines, because they're just
too large and too active to back up to TM, but that's okay.  The [Ansible][] setup
I use to create them was backed up.

But of course, bay 2 dropped out again during the rebuild three days ago.
This time, the
raid card notified me, and the machine is still running.  I have 2 more Hitachi
disks coming, hopefully one of them will be good, and I'll replace bay 2.  I'm
going to run on the 3 remaining good disks until they arrive.

But today I had to reboot it.  The disk drive showed up again, as "roaming",
which just means it isn't a part of the raid set.  I expected this.  What I
didn't expect was the computer informing me that the disk in Bay 2 is about
to fail.

![events](/pics/predicted-failure.png)

I spent a solid two minutes looking at that thinking "No shit, you couldn't
come up with this **two weeks ago**?  What the hell!"


[reported previously]: {{ site.baseurl }}{% post_url 2017-05-10-RS1-degraded %}
[Ansible]: https://docs.ansible.com/ansible/
[Time Machine]: https://en.wikipedia.org/wiki/Time_Machine_(macOS)
