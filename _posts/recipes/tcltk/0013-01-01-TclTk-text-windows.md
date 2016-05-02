---
layout: post
title:  "Text areas (editable and non editable)"
excerpt: "The text widget allows to display and possibly edit textual information."
author: james_and_philippe
modified: 2015-12-23
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

### An editable text window

Here is a text area that completelly fills a Tk window.


{% highlight r %}
library(tcltk2)

win1  <- tktoplevel()
tktitle(win1) <- "My first text widget!"
# Note that width and height are in number of characters and lines
win1$env$txt <- tk2text(win1, width = 60, height = 10)
tkpack(win1$env$txt, fill = "both", expand = TRUE)
tkfocus(win1$env$txt)

# A couple of commands to interact with the text widget:
# Add some text at the beginning of first line
tkinsert(win1$env$txt,
  "1.0", "Here is the text area...\nThis is a second line")
# Add text at the end of current one
tkinsert(win1$env$txt, "end", "\nFurther text added")
# Get the whole text
tclvalue(tkget(win1$env$txt, "0.0", "end"))
# Change the selection (select whole second line)
tktag.add(win1$env$txt, "sel", "2.0", "3.0")
# Place the cursor after the beginning of third line
# (cursor do not follow selection when it is set programmatically)
tkmark.set(win1$env$txt, "insert", "3.0")
# Get first position of the selection
tkindex(win1$env$txt, "sel.first")
# Get last poistion of the selection
tkindex(win1$env$txt, "sel.last")
# Get the range of the selection
tktag.ranges(win1$env$txt, "sel")
{% endhighlight %}

You can freely edit, cut, copy and paste in the text area.

![text area]({{ site.images }}/recipes-tcltk/text.png)


### A non-editable text window


{% highlight r %}
win2  <- tktoplevel()
tktitle(win2) <- "A read-only text"
win2$env$txt <- tk2text(win2, width = 60, height = 10)
tkpack(win2$env$txt, fill = "both", expand = TRUE)
# You must insert text before to disable edition!
tkinsert(win2$env$txt, "end", "Hello, world!\n(from a read-only text widget)")
tkconfigure(win2$env$txt, state = "disabled")
tkfocus(win2$env$txt)
{% endhighlight %}

Here is what you get. Try editing the text.

![text read-only]({{ site.images }}/recipes-tcltk/text2.png)


### A text window with a vertical scrollbar


{% highlight r %}
win3  <- tktoplevel()
tktitle(win3) <- "Text area with one scrollbar"
# Scrollbar must be defined first
win3$env$scr <- tk2scrollbar(win3, orient = "vertical",
  command = function(...) tkyview(win3$env$txt, ...))
win3$env$txt <- tk2text(win3, bg = "white",
  font = "courier", width = 60, height = 10,
  yscrollcommand = function(...) tkset(win3$env$scr, ...))
# Use grid manager, telling to occupy the whole area
tkgrid(win3$env$txt, win3$env$scr, sticky = "nsew")
# Indicate that win3$env$txt must spread in x and y on window resize
tkgrid.rowconfigure(win3, win3$env$txt, weight = 1)
tkgrid.columnconfigure(win3, win3$env$txt, weight = 1)
# Populate the text area with many lines
for (i in (1:100))
  tkinsert(win3$env$txt, "end", paste0(i, "^2 = ", i*i, "\n"))
tkconfigure(win3$env$txt, state = "disabled")
tkfocus(win3$env$txt)
{% endhighlight %}

![text scroll]({{ site.images }}/recipes-tcltk/text3.png)

Scrolling down reveals the remaining contents of the text widget: 

![text scrolled]({{ site.images }}/recipes-tcltk/text4.png)


### A text window with horizontal and vertical scrollbars (and no word wrap)


{% highlight r %}
win4  <- tktoplevel()
tktitle(win4) <- "Text area with two scrollbars"
# Scrollbars must be defined first
win4$env$scrx <- tk2scrollbar(win4, orient = "horizontal",
  command = function(...) tkxview(win4$env$txt, ...))
win4$env$scry <- tk2scrollbar(win4, orient = "vertical",
  command = function(...) tkyview(win4$env$txt, ...))
win4$env$txt <- tk2text(win4, width = 60, height = 10, wrap = "none",
  xscrollcommand = function(...) tkset(win4$env$scrx, ...),
  yscrollcommand = function(...) tkset(win4$env$scry, ...))
tkgrid(win4$env$txt, win4$env$scry, sticky = "nsew")
tkgrid.rowconfigure(win4, win4$env$txt, weight = 1)
tkgrid.columnconfigure(win4, win4$env$txt, weight = 1)
tkgrid(win4$env$scrx, sticky = "ew")
# Populate the text area with many lines
for (i in (1:100))
  tkinsert(win4$env$txt, "end", paste0(i, "^2 = ", i*i, ", "))
tkconfigure(win4$env$txt, state = "disabled")
tkfocus(win4$env$txt)
{% endhighlight %}

![text double-scroll]({{ site.images }}/recipes-tcltk/text5.png)

Scrolling across reveals the remaining contents of the text widget: 

![text double-scroll scrolled]({{ site.images }}/recipes-tcltk/text6.png)


### Entering Unicode characters in text windows

You can call a dialog box to enter Unicode characters from within R with the **tcltk2** function `tk2unicode_select()` function:


{% highlight r %}
win5 <- tktoplevel()
win5$env$txt <- tk2text(win5, width = 60, height = 10)
tkpack(win5$env$txt, fill = "both", expand = TRUE)
# Call the Unicode dialog box
tk2unicode_select(win5$env$txt)
{% endhighlight %}

You should see the following dialog box:

![unicode dialog box]({{ site.images }}/recipes-tcltk/text7.png)

Naviguate through code pages, then select the character you want by double-click or by hitting `Enter`. The character is inserted into the target widget. Now, close the Unicode character selector, but don't close the text window yet. It is also possible to define a _compose key_ (`Cmp`), that is, a key to trigger a sequence of two keys to be combined into a special unicode character. Of course, you can freely choose the compose key and the sequences you want to use. Obvious sequences are: `Cmp + ^ + e` → ê, `Cmp + a + e` → æ, etc. But you can also define other combinations like `Cmp + O + C` → ©, or `Cmp + m + u` → µ. for instance. Also, hitting the compose key twice brings back the Unicode selector. Here is how you can configure your `tk2text` text widget (or a `tk2entry` entry widget) to use the key composer:


{% highlight r %}
## Bind the key composer with our text widget
tk2unicode_bind(win5$env$txt)

## Call the key composer configuration dialog box
tk2unicode_config(win5)
{% endhighlight %}

Here is the key composer configuration dialog box (as you can see, it is called "Khim"):

![unicode configuration dialog box]({{ site.images }}/recipes-tcltk/text8.png)

You have the opportunity to save your configuration on disk. If you do so, it will persist from session to session.

![save configuration dialog box]({{ site.images }}/recipes-tcltk/text9.png)
