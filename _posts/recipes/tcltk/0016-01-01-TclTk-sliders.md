---
layout: post
title:  "Sliders in R TclTk"
excerpt: "Select values in a range with sliders in Tk Windows."
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

The following example illustrates how to use a slider in a Tk window.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()
tktitle(win1) <- "Slider"

# Use a linked Tcl variable to catch the value
sliderValue <- tclVar("50")

# Add a label with the current value of the slider
win1$env$label <- tk2label(win1,
  text = "Slider value: 50%")
tkgrid(win1$env$label, padx = 10, pady = c(15, 5))

# A function that changes the label
onChange <- function(...) {
  value <- as.integer(tclvalue(sliderValue))
  label <- sprintf("Slider value: %s%%", value)
  tkconfigure(win1$env$label, text = label)
}

# Add the slider
win1$env$slider <- tk2scale(win1, from = 0, to = 100,
  variable = sliderValue, orient = "horizontal", length = 200,
  command = onChange)
tkgrid(win1$env$slider, padx = 10, pady = c(5, 15))
{% endhighlight %}

The code above produces the following window:

![slider]({{ site.images }}/recipes-tcltk/slider.png)

Dragging the slider up to 95% gives the following:

![slider dragged]({{ site.images }}/recipes-tcltk/slider2.png)
