---
layout: post
title:  "Drop-down combobox"
excerpt: "A drop-down combobox widget for R TclTk."
author: james_and_philippe
modified: 2015-12-10
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

There is a `ttkcombobox()` drop-down combo box widgets in **tcltk**, and a very similar `tk2combobox()` in **tcltk2**. The following examples illustrate how to use it in a Tk window.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
win1$env$combo <- tk2combobox(win1)
tkgrid(win1$env$combo, padx = 10, pady = 15)

# A couple of functions to interact with the combobox:
# Fill the combobox list
fruits <- c("Apple", "Orange", "Banana")
tk2list.set(win1$env$combo, fruits)
# Add one or more elements to the list
tk2list.insert(win1$env$combo, "end", "Apricot", "Pear")
# Delete, query, get the list
tk2list.delete(win1$env$combo, 3)   # 0-based index!
tk2list.size(win1$env$combo)
tk2list.get(win1$env$combo)   # All items
# Link current selection to a variable
fruit <- tclVar("Orange")
tkconfigure(win1$env$combo, textvariable = fruit)

# Create a button to get the content of the combobox
onOK <- function() {
  tkdestroy(win1)
  msg <- paste0("Good choice! ", tclvalue(fruit), "s are delicious!")
  tkmessageBox(title = "Fruit Choice", message = msg)
}
win1$env$butOK <- tk2button(win1, text = "OK", width = -6, command = onOK)
tkgrid(win1$env$butOK, padx = 10, pady = c(0, 15))
{% endhighlight %}

The code above produces the following window:

![combobox]({{ site.images }}/recipes-tcltk/combobox.png)

Change the selection to "Pear"...

![combobox selection]({{ site.images }}/recipes-tcltk/combobox2.png)

... and click `OK`.

![combobox OK]({{ site.images }}/recipes-tcltk/combobox3.png)
