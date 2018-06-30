---
author: Wook
layout: post
title: Trying a "Headless CMS"
date: 2018-06-30 11:53:31 -0400
---
A while back, [I switched the blog to using Github Pages](2015/04/22/github-pages/).  I worked a bit to make the site look more like I wanted.  That was easy, because my desires were simple: white background, black-ish text, a nice font, the site's menus, readable width column.

What wasn't so easy was posting to the site.  It involved the following steps:

1. Open terminal
2. Copy a previous post so I got the Jekyll frontmatter to a new file
3. Write in new file
4. Remember to write correct markdown for links and pictures
5. Save file
6. Commit to local git repo
7. Remember to sign the commit with gpg
8. Push to git repo
9. Remember to push tags

So many posts I didn't make because the above was to much work just to create a post of the approximate sophistication and classiness of "I hab a code id by node."

So I was looking at a [medium.com post about static site generators](https://medium.com/dailyjs/how-to-choose-the-best-static-site-generator-in-2018-98bff61c8184 "How to Choose the Best Static Site Generator in 2018") by [Mathieu Dionne](https://medium.com/@MathDy24) and how they were taking over the world.  This was news to me.  I thought static site generators were for cranks like me that wanted my site to work and look like I wanted it to, but not have to host it myself.

I guess Github Pages should have been the first clue, here.  Github it not a small enterprise, so that Pages includes Jekyll for generating the HTML is actually kind of a huge thing.

In the article, it mentioned this new concept of "headless CMS".  Basically, a content management system that didn't actually serve the resulting pages.

And thus, we come to [Forestry.io](https://forestry.io/ "forestry.io").  It costs the same amount as Pages does for a single contributor like me.  Free.  And it should do everything I need.

It won't do the cryptographic signature I was using.  But really, there's little reason for me to have that.  I'm not a researcher.  My ramblings are for me only.  Nobody will take any of this seriously enough that if the site gets hacked I'm going to start a war or something.  I can still back up the site to my local machine at Wook Central by a single git pull command.

Will I post more using this method.  We'll see.