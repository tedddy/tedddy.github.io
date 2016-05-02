---
layout: post
title:  "Text labels in Tk windows"
excerpt: "Adding and changing text labels with Tk."
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

Text labels can easily be added to a toplevel window using the `tklabel()` or `ttklable()` functions in **tcltk**, or the `tk2label()` function in **tcltk2**. It is not necessary to assign the result of `tklabel()` to a variable unless you want to change the text later on.


{% highlight r %}
library(tcltk2)
win1 <- tktoplevel()
tkgrid(tk2label(win1, text = "This is a text label"))
{% endhighlight %}

![label]({{ site.images }}/recipes-tcltk/label.png)

The following code illustrates how the text in a label can be linked to a variable:


{% highlight r %}
win2 <- tktoplevel()
labelText <- tclVar("This is a text label")
win2$env$label <- tk2label(win2, textvariable = labelText)
tkgrid(win2$env$label)

changeText <- function()
  tclvalue(labelText) <- "This text label has changed!"
win2$env$butChange <- tk2button(win2, text = "Change text label", command = changeText)
tkgrid(win2$env$butChange)
{% endhighlight %}

Running the R code above gives the following window:

![label changeable]({{ site.images }}/recipes-tcltk/label2.png)

Pressing the "Change text label" button, gives the following window:

![label changed]({{ site.images }}/recipes-tcltk/label3.png)
