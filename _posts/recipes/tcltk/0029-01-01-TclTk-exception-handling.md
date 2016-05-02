---
layout: post
title:  "Exception handling in R TclTk"
excerpt: "Control errors and the way exceptions are handled in Tcl."
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

Here we describe just one possible strategy for catching errors in R Tcl/Tk applications and displaying them in message boxes. If using R Tcl/Tk in Windows, one quickly notices that the RGui main window frequently "gets in the way", as R Tcl/Tk windows like to hide behind it. It therefore becomes convenient to bypass RGui altogether and just use a batch file to run Rterm with your R TclTk code. Rather than searching for errors in a `.Rout` file, it is nicer to see errors pop up as you are running the application.


### Try()

We define a `Try()` function which tries to evaluate an R expression. If the expression evaluates succesfully, then the expected result is returned. If the expression causes an error, then this error is displayed in a message box.


{% highlight r %}
Try <- function(expr) {
  res <- try(expr, silent = TRUE)
  if (inherits(res, "try-error")) {
    library(tcltk2)
    tkmessageBox(title = "An error has occured!",
      message = as.character(res), icon = "error", type = "ok")
  }
  res
}
{% endhighlight %}


### Try() example


{% highlight r %}
Try(x <- 5)
## [1] 5

Try(tkmessageBox("Hello, world!\n"))
{% endhighlight %}

![error message]({{ site.images }}/recipes-tcltk/error.png)

We got an error because we should have used:


{% highlight r %}
tkmessageBox(message = "Hello, world!\n")
{% endhighlight %}

Note that if you want to apply `Try()` to more than one expression at once, you must enclose the expressions within braces.


### A better Try()

This error shown above is useful, but we are not interested in reading the first part of the error message for every single **Tcl** error, so we will 
use a regular expression to track and eliminate it in a refined version of our  `Try()` function for Tcl/Tk commands.


{% highlight r %}
Try <- function(expr) {
  res <- try(expr, silent = TRUE)
  if (inherits(res, "try-error")) {
    library(tcltk2)
    res <- sub("^.+\n +\\[tcl\\] ", "Tcl error: ", res)
    tkmessageBox(title = "An error has occured!",
      message = as.character(res), icon = "error", type = "ok")
  }
  res
}
{% endhighlight %}

### Try() example, take two


{% highlight r %}
Try(tkmessageBox("Hello, world!\n"))
{% endhighlight %}

![better error message]({{ site.images }}/recipes-tcltk/error2.png)


### Failure to load an R package

Below is a function which can be used to try to load a package. If the package cannot be found, an error is displayed in a message box.


{% highlight r %}
Require <- function(pkg, ...) {
  res <- try(library(pkg, character.only = TRUE, ...), silent = TRUE)
  if (inherits(res, "try-error")) {
    library(tcltk2)
    tkmessageBox(title = "An error has occured!",
      message = paste0("Cannot find package \"", pkg, "\". ",
        "May be try installing it first with install.packages(\"",
        pkg, "\")?"), icon = "error", type = "ok")
    return (FALSE)
  } else {
    return (TRUE)
  }
}
{% endhighlight %}


### Require() example


{% highlight r %}
Require("base")
## [1] TRUE
Require("aPackage")
## [1] FALSE
{% endhighlight %}

![missing R package error message]({{ site.images }}/recipes-tcltk/error3.png)

### Failure to load a Tcl package

Below is a function which can be used to try to load/require a Tcl package. If the package cannot be found, an error is displayed in a message box.


{% highlight r %}
TclRequire <- function(tclPkg) {
  library(tcltk2)
  res <- suppressWarnings(tclRequire(tclPkg))
  if (is.logical(res) && res == FALSE) {
    tkmessageBox(title = "An error has occured!",
      message = paste0("Cannot find Tcl package \"", tclPkg,
      "\". To access Tcl/Tk extensions, you must have Tcl/Tk installed ",
      "on your computer, not just the minimal Tcl/Tk installation which ",
      "comes with R. If you do have the full Tcl/Tk installed, make sure ",
      " that R can find the path to the Tcl library, e.g. C:\\Tcl\\lib ",
      "(on Windows) or /usr/local/ActiveTcl/lib (on Linux/Unix) or ",
      "/Library/Tcl on Mac OSX. To tell R where to find the Tcl library, ",
      "use addTclPath(\"<path to Tcl library>\").\n\n",
      "If using Windows, be sure to read the R for windows FAQ at ",
      "https://cran.r-project.org/bin/windows/base/rw-FAQ.html\n\n",
      "Make sure you have the TCL_LIBRARY environment variable set to the ",
      "appropriate path, e.g., C:\\Tcl\\lib\\tcl8.6 and the MY_TCLTK ",
      "environment variable set to a non-empty string, e.g. \"Yes\"."),
      icon = "error", type = "ok")
    return (FALSE)
  } else {
    return (TRUE)
  }
}
{% endhighlight %}

## TclRequire() example


{% highlight r %}
TclRequire("Tk")
## [1] TRUE
TclRequire("foo")
## [1] FALSE
{% endhighlight %}

![missing Tcl package error message]({{ site.images }}/recipes-tcltk/error4.png)
