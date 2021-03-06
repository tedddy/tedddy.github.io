---
layout: post
title:  "Cursors in R TclTk"
excerpt: "Manage cursors in Tk windows and widgets."
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

When one has to complete a time-consuming computation, it is nice to let the user know that the computer is busy by providing a wait cursor. The following example shows how to change the cursor, although there is no time-consuming computation in this case.


{% highlight r %}
library(tcltk2)
win1 <- tktoplevel()
tkconfigure(win1, cursor = "watch")
{% endhighlight %}

After the computation has finished, you can change the cursor back to the normal arrow with:


{% highlight r %}
tkconfigure(win1, cursor = "left_ptr")
{% endhighlight %}

### Other cursors

The following cursors are recognized on all platforms:

```
X_cursor
arrow
based_arrow_down
based_arrow_up
boat
bogosity
bottom_left_corner
bottom_right_corner
bottom_side
bottom_tee
box_spiral
center_ptr
circle
clock
coffee_mug
cross
cross_reverse
crosshair
diamond_cross
dot
dotbox
double_arrow
draft_large
draft_small
draped_box
exchange
fleur
gobbler
gumby
hand1
hand2
heart
icon
iron_cross
left_ptr
left_side
left_tee
leftbutton
ll_angle
lr_angle
man
middlebutton
mouse
pencil
pirate
plus
question_arrow
right_ptr
right_side
right_tee
rightbutton
rtl_logo
sailboat
sb_down_arrow
sb_h_double_arrow
sb_left_arrow
sb_right_arrow
sb_up_arrow
sb_v_double_arrow
shuttle
sizing
spider
spraycan
star
target
tcross
top_left_arrow
top_left_corner
top_right_corner
top_side
top_tee
trek
ul_angle
umbrella
ur_angle
watch
xterm
```
