---
layout: post
title:  "Simple non-modal dialog box"
excerpt: "Create a non-modal dialog box with a title and OK / Cancel buttons."
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

The R code below illustrates some of the basic R TclTk functions required to create a non-modal dialog box. Non-modal means that the user is not forced to respond to this dialog box immediately. Instead the user can change the focus to another window and do something else before responding to this dialog box.

A Tcl variable `done` is used to keep track of the state of the dialog box (active, closed with OK, or closed with Cancel/Destroyed). The `tkgrid()` function is used to layout the buttons on the window. The `tkbind()` function is used to capture the event of the window being destroyed, e.g. with the cross in the upper right-hand corner or with `Alt-F4` (in Windows) and to bind this event to a function which sets the state variable (`done`) appropriately. In order to demonstrate how to determine whether `OK` or `Cancel` was pressed, a message box is used in each case to announce the result of the dialog box.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()  # Create a new toplevel window
tktitle(win1) <- "Simple Dialog"  # Give the window a title

# Create a variable to keep track of the state of the dialog window:
#  If the window is active,                                            done = 0
#  If the window has been closed using the OK button,                  done = 1
#  If the window has been closed using the Cancel button or destroyed, done = 2
done <- tclVar(0)   # tclVar() creates a Tcl variable

# Create two buttons and for each one, set the value of the done variable
# to an appropriate value
win1$env$butOK <- tk2button(win1, text = "OK", width = -6,
  command = function() tclvalue(done) <- 1)
win1$env$butCancel <- tk2button(win1, text = "Cancel", width = -6,
  command = function() tclvalue(done) <- 2)

# Place the two buttons on the same row in their assigned window (win1)
tkgrid(win1$env$butCancel, win1$env$butOK, padx = 20, pady = 15)

# Capture the event "Destroy" (e.g. Alt-F4 in Windows) and when this happens,
# assign 2 to done
tkbind(win1, "<Destroy>", function() tclvalue(done) <- 2)
tkfocus(win1)         # Place the focus to our Tk window

# Do not proceed with the following code until the variable done is non-zero.
# (but other processes can still run, i.e., the system is not frozen)
tkwait.variable(done)

# The variable done is now non-zero, so we would like to record its value before
# destroying the window win1.  If we destroy it first, then done will be set to 2
# because of our earlier binding, but we want to determine whether the user
# pressed OK (i.e., see whether done is equal to 1)

doneVal <- tclvalue(done)   # Get content of a Tcl variable
tkdestroy(win1)

# Test the result
switch(doneVal,
  "1" = tkmessageBox(message = "You pressed OK!"),
  "2" = tkmessageBox(message = "You either pressed Cancel or destroyed the dialog!")
)
{% endhighlight %}

Running the R code above results in the following window:

![Non modal]({{ site.images }}/recipes-tcltk/nonmodal.png)

The dialog is resizable by default, so you can easily make it big enough to see the title by dragging any of the edges or corners with the mouse. If you want the buttons to lay out nicely when de dialog is resized, you will need a little bit more work, or you should use `tkpack()` instead.

The result of pressing `OK` is shown below:

![Non modal OK]({{ site.images }}/recipes-tcltk/nonmodal2.png)

The result of pressing `Cancel` is shown below:

![Non modal Cancel]({{ site.images }}/recipes-tcltk/nonmodal3.png)
