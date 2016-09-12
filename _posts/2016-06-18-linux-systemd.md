---
layout: post
title: systemd
author: Wook
date: 2016-06-18 13:06:00 -0500
---
I've been working with CentOS and RHEL 7 lately, and had to get into
using systemd and systemctl instead of the "service" command and the 
init.d system.

I gotta say, systemd is a cool piece of work...

...writen by a Windows user, for Windows users.

And no, I don't mean that in a good way.  This thing is fantastic for
the desktop, but hardly applicable on servers.  Linux lost on the
desktop and owns servers.

The Mac has the launchctl system, which is an earlier re-do of the
unix init system, and systemd looks a lot like it.  Systemd is more
capable in many ways, but none of those ways are going to make it
easier for humans to administrate servers.  Binary log files are
hostile to server admins for starters.

Leaves me wondering why we need this on Linux servers.
