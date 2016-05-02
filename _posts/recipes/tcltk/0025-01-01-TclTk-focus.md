---
layout: post
title:  "Focusing a window"
excerpt: "Change the focus to Tk windows programmatically."
author: james_and_philippe
modified: 2015-12-24
categories: [recipes, tcltk]
section: "Advanced tcltk coding"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

The following example makes window `win1` the active window.


{% highlight r %}
win1 <- tktoplevel() # A created windows is automatically focused
{% endhighlight %}

![a focused Tk window]({{ site.images }}/recipes-tcltk/focus.png)


{% highlight r %}
win2 <- tktoplevel() # Now the focus is on win2
{% endhighlight %}

![a new focused Tk window]({{ site.images }}/recipes-tcltk/focus2.png)


{% highlight r %}
tkraise(win1)        # Reclaim the focus on win1
{% endhighlight %}

![refocus on the first window]({{ site.images }}/recipes-tcltk/focus3.png)
