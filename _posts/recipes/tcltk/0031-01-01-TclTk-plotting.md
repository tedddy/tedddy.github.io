---
layout: post
title:  "Plotting graphs with tkrplot"
excerpt: "Include R plots in a Tk GUI using the tkrplot R package."
author: james_and_philippe
modified: 2015-12-25
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

The following example shows how to plot a graph in a Tk window, using the **tkrplot** package.


{% highlight r %}
library(tcltk2)
library(tkrplot)

hscale <- 1.5    # Horizontal scaling
vscale <- 1.5    # Vertical scaling

plotTk <- function() {
  x <- -100:100
  y <- x^2
  plot(x, y, main = "A parabola")
}

win1 <- tktoplevel()
tktitle(win1) <- "A parabola"

win1$env$plot <- tkrplot(win1, fun = plotTk,
  hscale = hscale, vscale = vscale)
tkgrid(win1$env$plot)
{% endhighlight %}

The code listed above gives the following graph window:

![R plot in a Tk window]({{ site.images }}/recipes-tcltk/plot.png)

It is worth noting that **tkrplot** places the graph on the clipboard (in Windows or X11) before it plots it on the window. This means that once a graph has been plotted, it can easily be pasted into another program. However, if a second graph is plotted, the first graph will be lost from the clipboard, so the software developer may wish to include a `Copy to Clipboard` button or menu item on the **tkrplot** graph window, so that the user can come back to it later and copy it to the clipboard. This can be done using the `tkrreplot()` function as follows:


{% highlight r %}
library(tcltk2)
library(tkrplot)

hscale <- 1.5    # Horizontal scaling
vscale <- 1.5    # Vertical scaling

plotTk <- function() {
  x <- -100:100
  y <- x^2
  plot(x, y, main = "A parabola")
}

win2 <- tktoplevel()
tktitle(win2) <- "A parabola"

win2$env$plot <- tkrplot(win2, fun = plotTk,
  hscale = hscale, vscale = vscale)

copyToClipboard <- function() tkrreplot(win2$env$plot)
win2$env$butCopy <- tk2button(win2, text = "Copy to Clipboard",
  command = copyToClipboard)
tkgrid(win2$env$butCopy, padx = 10, pady = 5, sticky = "nw")
tkgrid(win2$env$plot)
{% endhighlight %}

The code listed above gives the following graph window:

![R plot with copy button]({{ site.images }}/recipes-tcltk/plot2.png)
