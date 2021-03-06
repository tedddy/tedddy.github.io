---
layout: post
title:  "Radiobuttons in R TclTk"
excerpt: "Radiobuttons in Tk window for selection in a limited number of items."
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

The following example illustrates the use of radiobuttons in a Tk toplevel window. The choice of radiobutton is mapped to a Tcl variable called `rbValue`, which is initialized to `"oranges"`, which is the value of the second radio button (i.e. initially, the second radio button will be selected). The `onOK()` function triggered by the `OK` button captures the value of the Tcl variable mapped to the radiobuttons (`rbValue`) before destroying the window. Then it displays an appropriate message box depending on the choice.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
win1$env$rb1 <- tk2radiobutton(win1)
win1$env$rb2 <- tk2radiobutton(win1)
rbValue <- tclVar("oranges")
tkconfigure(win1$env$rb1, variable = rbValue, value = "apples")
tkconfigure(win1$env$rb2, variable = rbValue, value = "oranges")
tkgrid(tk2label(win1, text = "Which fruits do you prefer?"),
  columnspan = 2, padx = 10, pady = c(15, 5))
tkgrid(tk2label(win1, text = "Apples"), win1$env$rb1,
  padx = 10, pady = c(0, 5))
tkgrid(tk2label(win1, ,text = "Oranges"), win1$env$rb2,
  padx = 10, pady = c(0, 15))

onOK <- function() {
  rbVal <- as.character(tclvalue(rbValue))
  tkdestroy(win1)
  switch(rbVal,
    "apples" = tkmessageBox(
      message = "Good choice! An apple a day keeps the doctor away!"),
    "oranges" = tkmessageBox(
      message = "Good choice! Oranges are full of vitamin C!")
  )
}
win1$env$butOK <- tk2button(win1, text = "OK", width = -6, command = onOK)
tkgrid(win1$env$butOK, columnspan = 2, padx = 10, pady = c(5, 15))
tkfocus(win1)
{% endhighlight %}

You should get a window similar to this one:

![radiobutton oranges]({{ site.images }}/recipes-tcltk/radiobutton.png)

Click `OK` without changing the selection...

![radiobutton oranges OK]({{ site.images }}/recipes-tcltk/radiobutton2.png)

Now, rerun the code and select `Apples`:

![radiobutton apples]({{ site.images }}/recipes-tcltk/radiobutton3.png)

Click `OK`...

![radiobutton apples OK]({{ site.images }}/recipes-tcltk/radiobutton4.png)
