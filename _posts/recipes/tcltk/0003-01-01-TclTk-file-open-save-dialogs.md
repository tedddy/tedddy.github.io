---
layout: post
title:  "File Open/Save dialogs in R tcltk"
excerpt: "Select files with dialog boxes."
author: james_and_philippe
modified: 2015-12-01
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

### The Open file dialog


{% highlight r %}
library(tcltk2)
filename <- tclvalue(tkgetOpenFile()) # Very simple, isn't it?
if (!nchar(filename)) {
  tkmessageBox(message = "No file was selected!")
} else {
  tkmessageBox(message = paste("The file selected was", filename))
}
{% endhighlight %}

The code above produces the following window:

![An Open file box]({{ site.images }}/recipes-tcltk/opensavebox.png)

![Messagebox]({{ site.images }}/recipes-tcltk/opensavebox2.png)


### The Save file dialog


{% highlight r %}
filename <- tclvalue(tkgetSaveFile())
if (!nchar(filename)) {
  tkmessageBox(message = "No file was selected!")
} else {
  tkmessageBox(message = paste("The file selected was", filename))
}
{% endhighlight %}

With this code, you get the following dialog box:

![A Save file box]({{ site.images }}/recipes-tcltk/opensavebox3.png)

Now we will assume that the user pressed `Cancel`:

![Messagebox]({{ site.images }}/recipes-tcltk/opensavebox4.png)


### Opening CSV files with the open file dialog

Here is how you can specify to the **OpenFile** dialog the type of files to look for:


{% highlight r %}
getcsv <- function() {
  name <- tclvalue(tkgetOpenFile(
    filetypes = "{ {CSV Files} {.csv} } { {All Files} * }"))
  if (name == "")
    return(data.frame()) # Return an empty data frame if no file was selected
  data <- read.csv(name)
  assign("csv_data", data, envir = .GlobalEnv)
  cat("The imported data are in csv_data\n")
}

win1 <- tktoplevel()
win1$env$butSelect <- tk2button(win1, text = "Select CSV File", command = getcsv)
tkpack(win1$env$butSelect)
# The content of the CSV file is placed in the variable 'csv_data' in the global environment
{% endhighlight %}

![Button to open a file]({{ site.images }}/recipes-tcltk/opensavebox5.png)

Pressing the button gives the following **OpenFile** dialog, which knows which file extension to look for. In this case, only files with the extension `.csv` are displayed.

![Open a csv file box]({{ site.images }}/recipes-tcltk/opensavebox6.png)


### Saving (or opening) files with more than one possible extension

Multiple possibilities for file extensions (e.g., `.jpg` and `.jpeg`) can be separated by a space as follows:


{% highlight r %}
jpeg_filename <- tclvalue(tkgetSaveFile(initialfile = "foo.jpg",
  filetypes = "{ {JPEG Files} {.jpg .jpeg} } { {All Files} * }"))
{% endhighlight %}

![Open Jpeg file box]({{ site.images }}/recipes-tcltk/opensavebox7.png)
