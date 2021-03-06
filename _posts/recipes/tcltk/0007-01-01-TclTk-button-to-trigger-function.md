---
layout: post
title:  "A button that triggers a function call"
excerpt: "Create a Tk button that calls a R function when clicked."
author: james_and_philippe
modified: 2015-12-09
categories: [recipes, tcltk]
section: "Basic widgets"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

The following R code maps the `OK` button of a Tk toplevel window to a R function which displays a message box. We give a minimum size of six characters for the button (by using a negative value for its `width`).


{% highlight r %}
library(tcltk2)

pressedOK <- function()
  tkmessageBox(message = "You pressed OK!")

win1 <- tktoplevel()	# Create a new Tk window
win1$env$butOK <- tk2button(win1, text = "OK", width = -6, command = pressedOK)
tkgrid(win1$env$butOK, padx = 20, pady = 15)		# Place the button on the window
{% endhighlight %}

The toplevel window is shown below. We have not given it a title (using `tktitle()` or `tkwm.title()`), so the title bar displays the Tcl ID for this window, which is `1` in this case.

![OK button]({{ site.images }}/recipes-tcltk/button.png)

The result of pressing OK is shown below:

![OK button pressed]({{ site.images }}/recipes-tcltk/button2.png)

To close the tk window from within R, use:


{% highlight r %}
tkdestroy(win1)       # Kill the 'win1' Tk window
{% endhighlight %}
