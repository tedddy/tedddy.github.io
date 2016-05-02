---
layout: post
title:  "Menus in TclTk"
excerpt: "Add menus and pop-up menus to a R Tcl/Tk window."
author: james_and_philippe
modified: 2015-12-09
categories: [recipes, tcltk]
section: "Basic techniques"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

### A Simple file menu

The example below illustrates how to add a simple menu to a Tk toplevel window.


{% highlight r %}
library(tcltk2)
win1 <- tktoplevel()
win1$env$menu <- tk2menu(win1)           # Create a menu
tkconfigure(win1, menu = win1$env$menu)  # Add it to the 'win1' window
win1$env$menuFile <- tk2menu(win1$env$menu, tearoff = FALSE)
tkadd(win1$env$menuFile, "command", label = "Quit",
  command = function() tkdestroy(win1))
tkadd(win1$env$menu, "cascade", label = "File", menu = win1$env$menuFile)
{% endhighlight %}

Running the code above gives the following window:

![Simple menu]({{ site.images }}/recipes-tcltk/menus.png)


### Cascading menus within other menus

The example below illustrates how to cascade menu within another menu.


{% highlight r %}
win2 <- tktoplevel()
win2$env$menu <- tk2menu(win2)
tkconfigure(win2, menu = win2$env$menu)
win2$env$menuFile <- tk2menu(win2$env$menu, tearoff = FALSE)
# Our cascaded menu
win2$env$menuOpenRecent <- tk2menu(win2$env$menuFile, tearoff = FALSE)
tkadd(win2$env$menuOpenRecent, "command", label = "Recent File 1",
  command = function() tkmessageBox(
    message = "I don't know how to open Recent File 1", icon = "error"))
tkadd(win2$env$menuOpenRecent, "command", label = "Recent File 2",
  command = function() tkmessageBox(
    message = "I don't know how to open Recent File 2", icon = "error"))
tkadd(win2$env$menuFile, "cascade", label = "Open recent file",
  menu = win2$env$menuOpenRecent)
tkadd(win2$env$menuFile, "command", label = "Quit",
  command = function() tkdestroy(win2))
tkadd(win2$env$menu, "cascade", label = "File", menu = win2$env$menuFile)
{% endhighlight %}

Running the code above gives the following window:

![Cascaded menu]({{ site.images }}/recipes-tcltk/menus2.png)


### Adding a pop-up menu to a text window

The example below demonstrates how to add a simple pop-up menu to a text window. The hard part is determining the mouse coordinates in order to ensure that the menu appears where the mouse is right-clicked. Note that the keyboard shortcuts for copying and pasting (`<Ctrl-C>` and `<Ctrl-V>`) are mapped automatically for a Tk text widget.


{% highlight r %}
win3 <- tktoplevel()
win3$env$txt <- tk2text(win3)         # Create a text widget
tkpack(win3$env$txt, fill = "both")   # And place it on 'win3'

# Create the popup menu, and its associated R function
copyText <- function()
  .Tcl(paste("event", "generate", .Tcl.args(.Tk.ID(win3$env$txt), "<<Copy>>")))
win3$env$txtPopup <- tk2menu(win3$env$txt, tearoff = FALSE)
tkadd(win3$env$txtPopup, "command", label = "Copy", command = copyText)

# The function that displays the popup menu at the right place
rightClick <- function(x, y) { # x and y are the mouse coordinates
  # tkwinfo() return several infos
  rootx <- as.integer(tkwinfo("rootx", win3$env$txt))
  rooty <- as.integer(tkwinfo("rooty", win3$env$txt))
  xTxt <- as.integer(x) + rootx
  yTxt <- as.integer(y) + rooty
  # Create a Tcl command in a character string and run it
  .Tcl(paste("tk_popup", .Tcl.args(win3$env$txtPopup, xTxt, yTxt)))
}
tkbind(win3$env$txt, "<Button-3>", rightClick) # Tcl recognizes three mouse buttons
# For mouses having two buttons, the right one is still labelled 'Button-3'!
{% endhighlight %}

Here is what you get when you run this code:

![Popup menu]({{ site.images }}/recipes-tcltk/menus3.png)
