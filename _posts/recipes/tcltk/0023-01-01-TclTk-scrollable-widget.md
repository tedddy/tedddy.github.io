---
layout: post
title:  "The scrollable frame"
excerpt: "Manage larger areas that the window size easily."
author: james_and_philippe
modified: 2015-12-24
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

_Note: this has not been edited yet from the original form_

This example shows a scrollable frame (from the BWidget package). This is useful if you have an unknown number of entry widgets on a dialog and you don't know whether they will fit in a normal-sized dialog.

The BWidget package is not included in the minimal installation of Tcl/Tk which comes with R. You will have to install it separately.


{% highlight r %}
library(tcltk2)
tclRequire("BWidget")
tt <- tktoplevel()
tkpack(tklabel(tt, text = "This is not part of the scrollable frame"))
sw <- tkwidget(tt, "ScrolledWindow", relief = "sunken", borderwidth = 2)
sf <- tkwidget(sw, "ScrollableFrame")
tkcmd(sw, "setwidget", sf)
subfID <- tclvalue(tkcmd(sf, "getframe"))
lab <- tkcmd("label", paste0(subfID, ".lab"),
  text = "This is a Scrollable Frame")
tkpack(lab)
entryList <- list()
for (i in (1:20)) {
  entryList[[i]] <- tkcmd("entry", paste(subfID, i, sep = "."), width = 50)
  tkpack(entryList[[i]], fill = "x", pady = 4)
  tkbind(entryList[[i]], "<FocusIn>",
    function() tkcmd(sf, "see", entryList[[i]]))
  tkinsert(entryList[[i]], "end", paste("Text field", i))
}
tkpack(sw, fill = "both", expand = "yes")
{% endhighlight %}

The R code above produces a window with an area that can be scrolled up and down and that contains the 20 entries.
