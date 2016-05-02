---
layout: post
title:  "Edit boxes in R TclTk"
excerpt: "Single text line input widgets in Tk."
author: james_and_philippe
modified: 2015-12-22
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

The following example illustrates how to use an edit box in a Tk window. Note that the `Enter`/`Return` key is mapped to have the same effect as clicking the `OK` button with the mouse. A common mistake is to assume that the `<Enter>` event corresponds to the `Enter` key being pressed, but this would actually mean that the user is entering data into the Tk widget (in this case the edit box). So for this example, `<Return>` is the correct event to capture.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
name <- tclVar("Anonymous")
win1$env$entName <-tk2entry(win1, width = "25", textvariable = name)
tkgrid(tk2label(win1, text = "Please enter your first name:", justify = "left"),
  padx = 10, pady = c(15, 5), sticky = "w")
tkgrid(win1$env$entName, padx = 10, pady = c(0, 15))

onOK <- function() {
  nameVal <- tclvalue(name)
  tkdestroy(win1)
  msg <- paste("You have a nice name,", nameVal)
  tkmessageBox(message = msg)
}
win1$env$butOK <-tk2button(win1, text = "OK", width = -6, command = onOK)
tkgrid(win1$env$butOK, padx = 10, pady = c(5, 15))
tkbind(win1$env$entName, "<Return>", onOK)

tkfocus(win1)
{% endhighlight %}

![editbox]({{ site.images }}/recipes-tcltk/editbox.png)

Change name and click `OK`...

![editbox edited]({{ site.images }}/recipes-tcltk/editbox2.png)

![editbox OK]({{ site.images }}/recipes-tcltk/editbox3.png)
