---
layout: post
title:  "Modal dialog boxes"
excerpt: "Create a dialog box that freezes R until it is closed (modal)."
author: james_and_philippe
modified: 2015-12-09
categories: [recipes, tcltk]
section: "Basic techniques"
tags: [tcltk, GUI, programming]
image:
  feature: banner-tcltk.png
  credit: 
  creditlink: 
  teaser: banner-tcltk.png
comments: true
share: true
---

A modal dialog box requires the user to respond to it before changing the focus to other windows within the application. The Tk command `tk_dialog` is designed for this purpose, and can be called in R tcltk, using the `tkdialog()` function. However, the method illustrated below will use the `tktoplevel()` function and call `tkgrab.set()` and `tkgrab.release()` explicitly, rather than relying on `tkdialog()` to call them automatically.


{% highlight r %}
library(tcltk2)

modalDialog <- function(parent, title, question, entryInit, entryWidth = 20,
returnValOnCancel = "ID_CANCEL") {
  dlg <- tktoplevel()
  tkwm.deiconify(dlg)
  tkgrab.set(dlg)
  tkfocus(dlg)
  tkwm.title(dlg, title)
  textEntryVarTcl <- tclVar(paste(entryInit))
  textEntryWidget <- tk2entry(dlg, width = paste(entryWidth),
    textvariable = textEntryVarTcl)
  tkgrid(tklabel(dlg, text = question), textEntryWidget, padx = 10, pady = 15)
  returnVal <- returnValOnCancel
  
  onOK <- function() {
    returnVal <<- tclvalue(textEntryVarTcl)
    tkgrab.release(dlg)
    tkdestroy(dlg)
    tkfocus(parent)
  }
  
  onCancel <- function() {
    returnVal <<- returnValOnCancel
    tkgrab.release(dlg)
    tkdestroy(dlg)
    tkfocus(parent)
  }
  
  butOK <- tk2button(dlg, text = "OK", width = -6, command = onOK)
  butCancel <- tk2button(dlg, text = "Cancel", width = -6, command = onCancel)
  tkgrid(butCancel, butOK, padx = 10, pady = c(0, 15))
  
  tkfocus(dlg)
  tkbind(dlg, "<Destroy>", function() {tkgrab.release(dlg); tkfocus(parent)})
  tkbind(textEntryWidget, "<Return>", onOK)
  tkwait.window(dlg)
  
  returnVal
}

# Create a "main" window with a button which activates our dialog
win1 <- tktoplevel()
tktitle(win1) <- "Main window"
win1$env$launchDialog <- function() {
  returnVal <- modalDialog(win1, "First Name Entry", "Enter Your First Name:", "")
  if (returnVal == "ID_CANCEL") return()
  tkmessageBox(title = "Greeting",
    message = paste0("Hello, ", returnVal, "."))
}
win1$env$butDlg <- tk2button(win1, text = "Launch Dialog",
  command = win1$env$launchDialog)
tkpack(win1$env$butDlg, padx = 60, pady = 50)
{% endhighlight %}

![Modal button]({{ site.images }}/recipes-tcltk/modal.png)

Clicking on the `Launch Dialog` opens our modal dialog box, i.e., you must respond to it before you can change the focus back to the main window in the Tk application.

![Modal dialog]({{ site.images }}/recipes-tcltk/modal2.png)

Clicking `OK` gives the following message box:

![Modal OK]({{ site.images }}/recipes-tcltk/modal3.png)

When you have finished with this example, you can close `win1` with:


{% highlight r %}
tkdestroy(win1)
{% endhighlight %}

