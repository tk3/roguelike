#!/usr/bin/env ruby

require "curses"

message = "rougue"

height = 5
width = message.length + 2 + 4
top = 3
left = 4


Curses.curs_set(0)

win = Curses::Window.new(height, width, top, left)
win.box("|", "-", "+")
win.setpos(2, 3)
win.addstr(message)
win.refresh
c = win.get_char

