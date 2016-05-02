---
layout: post
title:  "Using the color-selection widget"
excerpt: "Select colors with a dialog box."
author: james_and_philippe
modified: 2015-12-23
categories: [recipes, tcltk]
section: "Additional widgets"
tags: [tcltk, GUI, programming, color]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

The following code creates a toplevel widget with a Tk canvas showing the currently selected color as its background, and a button which can be used to change the color.


{% highlight r %}
library(tcltk2)
win1 <- tktoplevel()
tkwm.title(win1,"Color Selection")

# Store the color name or code (#rrggbb) in a variable
color <- "blue"
win1$env$canvas <- tk2canvas(win1, width = 80, height = 25, bg = color)

# The button to call the color selector and change the color
changeColor <- function() {
  color <- tclvalue(.Tcl(paste("tk_chooseColor",
    .Tcl.args(initialcolor = color, title = "Choose a color"))))
  if (nchar(color) > 0)
    tkconfigure(win1$env$canvas, bg = color)
}
win1$env$butChange <- tk2button(win1, text = "Change Color",
  command = changeColor)

# Place both widgets sid-by-side
tkgrid(win1$env$canvas, win1$env$butChange, padx = 10, pady = 15)
{% endhighlight %}

![color test window]({{ site.images }}/recipes-tcltk/color.png)

Clicking on the `Change Color` button gives the color-selection widget:

![color selector]({{ site.images }}/recipes-tcltk/color2.png)

Change the color from blue to red:

![color selector after change]({{ site.images }}/recipes-tcltk/color3.png)

Click `Ok`. Now the color is updated on our canvas:

![color test window updated]({{ site.images }}/recipes-tcltk/color4.png)
