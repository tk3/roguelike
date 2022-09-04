#!/usr/bin/env ruby

require "curses"

Curses.init_screen

s = "@"
y = Curses.lines / 2
x = Curses.cols / 2 - (s.length / 2)

Curses.setpos(y, x)
Curses.addstr(s)
Curses.refresh

Curses.curs_set(0)

Curses.getch

