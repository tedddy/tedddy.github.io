---
layout: post
title:  "Interactive plots with tkrplot"
excerpt: "Interact with R plots in a Tk window using the tkrplot R package."
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

The R code for this example is a little longer than that of the simpler examples. The basic idea is that we put a scatter plot in a Tk window, using the **tkrplot** package by Luke Tierney. We then allow the user to click on (or near) one of the plotted points in order to attach a label to that point (and replot the graph).

The hardest part is mapping between image (Tk widget) coordinates and R plot coordinates, which is done in the function `onLeftClick()`.

Running the code below gives the following graph window:

![R plot]({{ site.images }}/recipes-tcltk/plot3.png)

Clicking on the upper-left point gives the following message box:

![Question]({{ site.images }}/recipes-tcltk/plot4.png)

After answering `Yes` to the message box question, the graph is updated. Note the label, `A` above the point that was clicked on.

![R plot with one point labelled]({{ site.images }}/recipes-tcltk/plot5.png)

After labeling all of the points, the graph looks like this:

![R plot with all points labelled]({{ site.images }}/recipes-tcltk/plot6.png)


### R code for interactive tkrplot example


{% highlight r %}
library(tcltk2)
library(tkrplot)

xCoords <- -12:13
yCoords <- xCoords^2
labelsVec <- LETTERS

indexLabeled <- c()
labeledPoints <- list()

win1 <- tktoplevel()
tktitle(win1) <- "Click on a point to label it"

parPlotSize <- c()
usrCoords <- c()

plotTk <- function() {
  plot(xCoords, yCoords, main = "Click on a point to label it")
  if (length(indexLabeled)) {
    for (i in (1:length(indexLabeled))) {
      indexClosest <- indexLabeled[i]
      text(xCoords[indexClosest], yCoords[indexClosest],
        labels = labelsVec[indexClosest], pos = 3)
    }
  }
  parPlotSize <<- par("plt")
  usrCoords   <<- par("usr")
}

win1$env$plot <- tkrplot(win1, fun = plotTk, hscale = 1.5, vscale = 1.5)
tkgrid(win1$env$plot)

labelClosestPoint <- function(xClick, yClick, imgXcoords, imgYcoords) {
  squaredDistance <- (xClick - imgXcoords)^2 + (yClick - imgYcoords)^2
  indexClosest <- which.min(squaredDistance)
  indexLabeled <<- c(indexLabeled, indexClosest)
  tkrreplot(win1$env$plot)
}

onLeftClick <- function(x, y) {
  xClick <- x
  yClick <- y
  width  <- as.numeric(tclvalue(tkwinfo("reqwidth", win1$env$plot)))
  height <- as.numeric(tclvalue(tkwinfo("reqheight", win1$env$plot)))

  xMin <- parPlotSize[1] * width
  xMax <- parPlotSize[2] * width
  yMin <- parPlotSize[3] * height
  yMax <- parPlotSize[4] * height

  rangeX <- usrCoords[2] - usrCoords[1]
  rangeY <- usrCoords[4] - usrCoords[3]

  imgXcoords <- (xCoords - usrCoords[1]) * (xMax - xMin) / rangeX + xMin
  imgYcoords <- (yCoords - usrCoords[3]) * (yMax - yMin) / rangeY + yMin

  xClick <- as.numeric(xClick) + 0.5
  yClick <- as.numeric(yClick) + 0.5
  yClick <- height - yClick

  xPlotCoord <- usrCoords[1] + (xClick - xMin) * rangeX / (xMax - xMin)
  yPlotCoord <- usrCoords[3] + (yClick - yMin)* rangeY / (yMax - yMin)

  msg <- paste0("Label the point closest to these ",
    "approximate plot coordinates: \n",
    "x = ", format(xPlotCoord, digits = 2),
    ", y = ", format(yPlotCoord, digits = 2), "?")
  mbval <- tkmessageBox(title =
    "Label Point Closest to These Approximate Plot Coordinates",
    message = msg, type = "yesno", icon = "question")

  if (tclvalue(mbval)== "yes")
    labelClosestPoint(xClick, yClick, imgXcoords, imgYcoords)
}

tkbind(win1$env$plot, "<Button-1>", onLeftClick)
tkconfigure(win1$env$plot, cursor = "hand2")
{% endhighlight %}
