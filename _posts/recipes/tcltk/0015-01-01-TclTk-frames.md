---
layout: post
title:  "Frames in R TclTk"
excerpt: "Use frames to organize widgets in Tk Windows."
author: james_and_philippe
modified: 2015-12-11
categories: [recipes, tcltk]
section: "Additional widgets"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

The following example illustrates how to use frames in a Tk window. Possible relief effects are `raised`, `sunken`, `flat`, `ridge`, `solid`, and `groove`. The `raised` and `sunken` effects would make the frame look like a button which is not currently being pressed (`raised`) or like a button which is currently being pressed (`sunken`).

The frame creates a container inside another container. It is useful for complex widget layout, or to combine two different managers in the same Tk window. The following code first uses `tkpack()` to place areas at the to and the left of the window. Then, it uses `tkgrid()` to layout a series of widgets inside a frame.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
tktitle(win1) <- "Use frames!"

# Define a frame inside 'win1'
win1$env$frm <- tk2frame(win1, borderwidth = 3, relief = "sunken",
  padding = 10)

# Pack a label at the top of the window
# Could be something like a message at the top...
# or an area for a toolbar
tkpack(tk2label(win1,
  text = "A label that is packed at the top of the window",
  width = 40, justify = "left", background = "#ffffff"),
  side = "top", expand = FALSE, ipadx = 5, ipady = 5,
  fill = "x")
# Pack a label at the bottom of the window
# Could be an area reserved for a status bar for instance
tkpack(tk2label(win1,
  text = "An area reserved at the bottom of the window",
  width = 40, justify = "left", background = "#ffffff"),
  side = "bottom", expand = FALSE, ipadx = 5, ipady = 5,
  fill = "x")
# Pack a label at the left (display a general text or image)
tkpack(tk2label(win1, text = "A label at the left of the window",
  wraplength = 50, relief = "sunken", background = "#999999"),
  side = "left", expand = FALSE,
  ipadx = 5, ipady = 5, fill = "both")
# Pack our frame in the remaining area, allowing it to expand
# (try resizing the window to see its effect)
tkpack(win1$env$frm, expand = TRUE, fill = "both")

# Now, you can populate your frame as if it was a separate
# container
# For instance, we could switch to the grid manager...
tkgrid(tk2label(win1$env$frm, text = "What is you name?"),
  columnspan = 2, padx = 10, pady = c(15, 5))
tkgrid(tk2entry(win1$env$frm),
  columnspan = 2, padx = 10, pady = c(5, 5))
tkgrid(
  # A Cancel button
  tk2button(win1$env$frm, text = "Cancel", width = -6,
    command = function() tkdestroy(win1)),
  tk2button(win1$env$frm, text = "OK", width = -6,
    command = function() tkdestroy(win1)),
  padx = 10, pady = c(5, 15))
{% endhighlight %}

The code above produces the following window:

![frame]({{ site.images }}/recipes-tcltk/frame.png)

Try resizing the window to see that the labels at top, bottom and left are nicely resized too. The content of the frame is **not** resized here.

![frame resized]({{ site.images }}/recipes-tcltk/frame2.png)
