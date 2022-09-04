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
Curses.noecho

while true do
  ch = Curses.getch

  case ch
  when 'h' then
    if (x - 1 >= 0) then
      Curses.setpos(y, x)
      Curses.addch(' ')

      x = x - 1
      Curses.setpos(y, x)
      Curses.addstr(s)
      Curses.refresh
    end
  end
end
