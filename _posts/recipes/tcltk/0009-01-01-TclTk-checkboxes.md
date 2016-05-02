---
layout: post
title:  "Checkboxes in R TclTk"
excerpt: "Creating and interacting with Tk checkboxes."
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

The following example illustrates the use of a checkbox in a Tk toplevel window. The value of the checkbox is mapped to a Tcl variable called `cbValue`, which is initialized to zero (i.e. the checkbox will be initially unchecked). The `onOK()` function triggered by the `OK` button captures the value of the Tcl variable mapped to the checkbox (`cbValue`) before destroying the window. Then it displays an appropriate message box depending on the value of the checkbox.



{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
win1$env$cb <- tk2checkbutton(win1, text = "I like R Tcltk")
cbValue <- tclVar("0")
tkconfigure(win1$env$cb, variable = cbValue)
tkgrid(win1$env$cb, padx = 20, pady = 15)

onOK <- function() {
  cbVal <- as.character(tclvalue(cbValue))
  tkdestroy(win1)
  switch(cbVal,
    "1" = tkmessageBox(message = "So do I!"),
    "0" = tkmessageBox(
      message = "You forgot to check the box to say that you like R TclTk!",
      icon = "warning")
  )  
}
win1$env$butOK <- tk2button(win1, text = "OK", width = -6, command = onOK)
tkgrid(win1$env$butOK, padx = 10, pady = c(0, 15))

tkfocus(win1)
{% endhighlight %}

You should get a window similar to this one:

![unchecked box]({{ site.images }}/recipes-tcltk/checkbox.png)

Click `OK` without checking the box...

![unchecked box not OK]({{ site.images }}/recipes-tcltk/checkbox2.png)

Now, rerun the code and check the box:

![checked box]({{ site.images }}/recipes-tcltk/checkbox3.png)

Click `OK`...

![checked box OK]({{ site.images }}/recipes-tcltk/checkbox4.png)
