#!/usr/bin/env ruby

require "curses"

class Room
  def initialize(height, width, top, left)
    @height = height
    @width = width
    @top = top
    @left = left
  end

  def box(vertical_char = "|", horizontal_char = "-")
    @vertical_char = vertical_char
    @horizontal_char = horizontal_char
  end

  def draw
    Curses.setpos(@top, @left)
    Curses.addstr(@horizontal_char * @width)

    Curses.setpos(@top + @height - 1, @left)
    Curses.addstr(@horizontal_char * @width)

    Curses.setpos(@top, @left)
    (@height - 2).times do |y|
      Curses.setpos(@top + y + 1, @left)
      Curses.addstr(@vertical_char)
    end

    Curses.setpos(@top + @height - 1, @left)
    (@height - 2).times do |x|
      Curses.setpos(@top + x + 1, @left + @width - 1)
      Curses.addstr(@vertical_char)
    end
  end

  def top_out(out_pos)
    @room.setpos(@top, outpos)
    @room.addstr(" ")
  end

end

height = 10
width = 12
top = 3
left = 4

room = Room.new(height, width, top, left)
room.box
room.draw

Curses.refresh
Curses.get_char

