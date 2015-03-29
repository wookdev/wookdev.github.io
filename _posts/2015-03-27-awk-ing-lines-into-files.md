---
layout: post
title: Using awk To Add Lines To Files
author: Wook
tags:
  - awk
---

I had to stop and figure [awk][] out again.  I used to be almost ok with awk, but it's
been a while.

I have a bunch of files from previous incarnations of this blog.  I want to
add redirects from the old "munged.org/saga" locations to the new Jekyll
"2015-03-27-title-of-post" location.

There's a whole 'nother decision about maybe just [specifying a permalink][permalink]
in the source files to put the resulting html files in the /saga/ directory, so
they show up where they used to.  All my testing says Jekyll doesn't have a
problem with posts scattered all over the place via permalink.

But I kinda want to "move on" on this one.  Plus, this is also how I'd put in
the permalink variable in all the files anyway, so this work is not a bad thing.

And, I enjoyed dipping my toes in this again.  What the hell, ya know?

My requirements:

1. I'm going to only add lines to the files
1. I want to add the new lines just above the second '- - -'
1. The files must otherwise not be modified

The lines I need to add are:

{% highlight yaml %}
mtid: 1
redirect_from:
  - /saga/1.html
{% endhighlight %}

Where '1' is going to be a record number from the Moveable Type system.  I have
files with ids as high as 507.

I'm adding the mtid just to keep the ID number around.  Right now, it is part of the source
file name, but I want the data *IN* the file for safety.

For awk, I need two rules: one to write all the lines into the result file, and
another to add in the new lines before the second '- - -'.  The two rules are:

{% highlight awk %}
# pass 'id' in via the -v switch on the awk command line
/---/ && NR > 1 \
    {
        printf "mtid: %d\n", id
        printf "redirect_from:\n"
        printf "  - /saga/%d.html\n", id
    }
# print all lines
    { print $0 }
{% endhighlight %}

First, we select all lines with three dashes where the record number is greater than
1, so we select the second such record.  Then we write the new lines into the file.
The variable "id" has to come from the awk command line.  Finally, we write the line
out to the output.

The order is important.  Since I want the new lines before the '- - -' **AND** I want
the '- - -' in the output, I have to trigger on the '- - -' and add the new lines before
"print $0" writes the '- - -' line out.

This is invoked like so:

    awk -v id=504 -f ~/addid.awk source-file.md > output-file.md

If I was bulletproofing this, I would need to do two things that I'm not worrying
about on this pass:

1. Make sure the '- - -' I'm getting isn't part of a markdown "heading 2".

    One of the ways of creating a <h2> heading is:

        My 2nd-Level Heading
        --------------------

    I don't have any of this right now, so I'm not going to fix this.

2. Put in a BEGIN rule that checks to make sure 'id' is passed in from the command
   line.

I'll put the scripts in the [blog repo][] if you want to look at them.

[blog repo]:    https://github.com/wookdev/wookdev.github.io/tree/master/_tools
[awk]:          https://en.wikipedia.org/wiki/AWK
[permalink]:    http://jekyllrb.com/docs/frontmatter/ "Jekyll Docs"