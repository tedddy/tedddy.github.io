---
layout: post
title:  "Binding Tk events"
excerpt: "How to bind Tk events to R functions and generating events in R TclTk."
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

The table below lists the common events that one would want to capture or generate in a Tk window.

For examples of capturing an event, see the Edit Box example in which the event of the user pressing the `<Enter>` key is captured and mapped to a function, and see the `Dialog Box` with `OK` and `Cancel` example in which the action of destroying the window is made equivalent to pressing the `Cancel` button.

For an example of generating an event, see the `Pop-up Menu` example in which the event of copying text from a text widget into the clipboard is generated.


| Event          | Description                    |
|:---------------|:-------------------------------|
| `<Button-1>`     | A mouse button is pressed over the widget. Button 1 is the leftmost button, button 2 is the middle button (where available), and button 3 the rightmost button. When you press down a mouse button over a widget, Tkinter will automatically "grab" the mouse pointer, and mouse events will then be sent to the current widget as long as the mouse button is held down. The current position of the mouse pointer (relative to the widget) is provided in the x and y members of the event object passed to the callback. You can use ButtonPress instead of Button, or even leave it out completely: `<Button-1>`, `<ButtonPress-1>`, and `<1>` are all synonyms.  |
| `<B1-Motion>`  | The mouse is moved, with mouse button 1 being held down (use B2 for the middle button, B3 for the right button). The current position of the mouse pointer is provided in the x and y members of the event object passed to the callback. |
| `<ButtonRelease-1>` | Button 1 was released. The current position of the mouse pointer is provided in the x and y members of the event object passed to the callback. |
| `<Double-Button-1>`| Button 1 was double clicked. You can use Double or Triple as prefixes. Note that if you bind to both a single click (`<Button-1>`) and a double click, both bindings will be called. |
| `<Enter>`| The mouse pointer entered the widget (this event doesn't mean that the user pressed the Enter key!). |
| `<Leave>`| The mouse pointer left the widget. |
| `<Return>`| The user pressed the Enter key. You can bind to virtually all keys on the keyboard. For an ordinary 102-key PC-style keyboard, the special keys are `Cancel` (the Break key), `BackSpace`, `Tab`, `Return` (the Enter key), `Shift_L` (any Shift key), `Control_L` (any Control key), `Alt_L` (any Alt key), `Pause`, `Caps_Lock`, `Escape`, `Prior` (Page Up), `Next` (Page Down), `End`, `Home`, `Left`, `Up`, `Right`, `Down`, `Print`, `Insert`, `Delete`, `F1`, `F2`, `F3`, `F4`, `F5`, `F6`, `F7`, `F8`, `F9`, `F10`, `F11`, `F12`, `Num_Lock`, and `Scroll_Lock`. |
| `<Key>` | The user pressed any key. The key is provided in the char member of the event object passed to the callback (this is an empty string for special keys). |
| `a`| The user typed an "a". Most printable characters can be used as is. The exceptions are space (`<space>`) and less than (`<less>`). Note that `1` is a keyboard binding, while `<1>` is a button binding. |
| `<Shift-Up>`| The user pressed the Up arrow, while holding the Shift key pressed. You can use prefixes like `Alt`, `Shift`, and `Control`. |
| `<Configure>` | The widget changed size (or location, on some platforms). The new size is provided in the width and height attributes of the event object passed to the callback. |
