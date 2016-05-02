---
layout: post
title:  "Layout in R TclTk"
excerpt: "Specifying the layout."
author: james_and_philippe
modified: 2015-12-24
categories: [recipes, tcltk]
section: "Advanced tcltk coding"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

There are two main commands in Tk which are used to specify the layout of widgets on a window, `tkpack()` and `tkgrid()`. `tkgrid()` is newer and more flexible. Here is how it can be used.

With `tkgrid()`, "the grid manager", it is possible to specify absolute row and column numbers for widgets on a window, but this is not recommended, because it makes it difficult to insert new widgets later on (i.e. you would have to update all the row/column numbers). It ispossible to leave postion empty by inserting blank labels. It may be useful to sketch the grid on paper before starting coding your Tk widgets latyout.

Generally when using `tkgrid()` without specifying a row or column number, multiple arguments in the same call to `tkgrid()` are placed sequentially on the same row, and a subsequent call to `tkgrid()` will place widgets on the next row.

One very useful option in the `tkgrid()` function is the `sticky =` option. The value of this option can be an empty string, or any combination of the letters `"n"`, `"e"`, `"s"` and `"w"`, e.g. `"nsw"`. If just one letter is specified, then the widget is aligned at that edge of the grid cell (north, east, south or west). If two opposite directions are specified, e.g. `"ns"`, then the widget is stretched from the top of the cell to the bottom. If this is impossible, then it is just centered vertically, as it would be if neither `"n"` nor `"s"` were specified. If three letters are specified, e.g. `"sew"`, then the widget is stretched in one direction (in this case horizontally - between east and west), and aligned at the bottom (south) edge of the grid cell.


{% highlight r %}
library(tcltk2)

win1 <- tktoplevel()

tkgrid(tk2label(win1, text = "Here is a centered string of text."))
tkgrid(tk2label(win1, text = "Left"), sticky = "w")
tkgrid(tk2label(win1, text = "Right"), sticky = "e")

tkgrid(tk2label(win1, text = "    ")) # Blank line
tkgrid(tk2label(win1, text = "    ")) # Blank line

tkgrid(tklabel(win1, text =
  "Here is a much longer string of text, which takes up two columns."),   
  columnspan = 2)

win1$env$labLeft <- tk2label(win1, text = "Left")
win1$env$labRight <- tk2label(win1, text = "Right")
tkgrid(win1$env$labLeft, win1$env$labRight)
tkgrid.configure(win1$env$labLeft, sticky = "w")
tkgrid.configure(win1$env$labRight, sticky = "e")

win1$env$labLeft2 <- tk2label(win1, text = "LeftAligned")
win1$env$labRight2 <- tk2label(win1, text = "RightAligned")
tkgrid(win1$env$labRight2, win1$env$labLeft2)
tkgrid.configure(win1$env$labLeft2, sticky = "w")
tkgrid.configure(win1$env$labRight2 ,sticky = "e")

tkgrid(tk2label(win1, text = "    ")) # Blank line
tkgrid(tk2label(win1, text = "    ")) # Blank line

tkgrid(tk2label(win1, text = 
  "This sentence takes up two rows,\n but only one column"),
  rowspan = 2)
{% endhighlight %}

The code above produces the following window:

![various widgets layouts]({{ site.images }}/recipes-tcltk/layout.png)
