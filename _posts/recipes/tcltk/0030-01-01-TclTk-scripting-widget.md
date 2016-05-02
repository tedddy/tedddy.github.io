---
layout: post
title:  "Evaluating R code from a scripting Tk widget"
excerpt: "Create a script window to edit and evaluate R code in Tk."
author: james_and_philippe
modified: 2015-12-25
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

The following is taken from Peter Dalgaard's article in [R News 2002, Volume 3](https://cran.r-project.org/doc/Rnews/Rnews_2002-3.pdf).

### A scripting widget

The script-window application in Dalgaard (2001) got hit rather badly by the interface changes. Below is a version that works with the new interface. Notice that it is necessary to insert `tclvalue()` constructions in several places, even when the return values are only used as arguments to Tcl/Tk routines. You can sometimes avoid this because the default treatment of arguments (in `.Tcl.args()`) is to preprocess them with `as.character()`, but for objects of class **tclObj** this only works if there are no whitespace characters in the string representation. The contents of the script window and the files that are read can obviously contain spaces and it is also not safe to assume that file names and directory names are single words.


{% highlight r %}
library(tcltk2)

tkscript <- function() {
  wfile <- ""
  
  win <- tktoplevel()
  tktitle(win) <- "R script editor"
  
  scrx <- tk2scrollbar(win, orient = "horizontal",
    command = function(...) tkxview(txt, ...))
  scry <- tk2scrollbar(win, orient = "vertical",
    command = function(...) tkyview(txt, ...))
  txt <- tk2text(win, width = 60, height = 10, wrap = "none",
    xscrollcommand = function(...) tkset(scrx, ...),
    yscrollcommand = function(...) tkset(scry, ...))
  tkgrid(txt, scry, sticky = "nsew")
  tkgrid.rowconfigure(win, txt, weight = 1)
  tkgrid.columnconfigure(win, txt, weight = 1)
  tkgrid(scrx, sticky = "ew")
  
  save <- function() {
    file <- tclvalue(tkgetSaveFile(
      initialfile = tclvalue(tclfile.tail(wfile)),
      initialdir = tclvalue(tclfile.dir(wfile))))
    
    if (!length(file)) return()
  
    chn <- tclopen(file, "w")
    on.exit(tclclose(chn))
    tclputs(chn, tclvalue(tkget(txt, "0.0", "end")))
    wfile <<- file
  }

  load <- function() {
    file <- tclvalue(tkgetOpenFile())
    
    if (!length(file)) return()
  
    chn <- tclopen(file, "r")
    on.exit(tclclose(chn))
    tkinsert(txt, "0.0", tclvalue(tclread(chn)))
  
    wfile <<- file
  }

  run <- function() {
    code <- tclvalue(tkget(txt, "0.0", "end"))
    e <- try(parse(text = code))
    
    if (inherits(e, "try-error")) {
      tkmessageBox(message = "Syntax error", icon = "error")
      return()
    }
    
    cat("Executing from script window:",
      "-----", code, "result:", sep = "\n")
    print(eval(e))
  }

  topMenu <- tk2menu(win)
  tkconfigure(win, menu = topMenu)
  fileMenu <- tk2menu(topMenu, tearoff = FALSE)
  tkadd(fileMenu, "command", label = "Load", command = load)
  tkadd(fileMenu, "command", label = "Save", command = save)
  tkadd(topMenu, "cascade", label = "File", menu = fileMenu)
  tkadd(topMenu, "command", label = "Run", command = run)
}

tkscript()
{% endhighlight %}

The scripting widget is shown below with an example of some trivial R code:

![script window]({{ site.images }}/recipes-tcltk/script.png)

The results are displayed in the R console:


{% highlight r %}
## Executing from script window:
## -----
## mean(1:6)
## 
## result:
## [1] 3.5
{% endhighlight %}

Of course, it would also be possible to display the results in another Tk text window, rather than in the R console.
