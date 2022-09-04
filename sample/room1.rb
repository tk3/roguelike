#!/usr/bin/env ruby

require "curses"

class Room
  def initialize(height, width, y, x)
    @height = height
    @width = width
    @y = y
    @x = x
  end

  def box(vertical_char = "|", horizontal_char = "-")
    @vertical_char = vertical_char
    @horizontal_char = horizontal_char
  end

  def draw
    # top
    Curses.setpos(@y - 1, @x - 1)
    Curses.addstr(@horizontal_char * @width)

    # bottom
    Curses.setpos(@y - 1 + @height - 1, @x - 1)
    Curses.addstr(@horizontal_char * @width)

    # left
    (@height - 2).times do |y|
      Curses.setpos(@y - 1 + y + 1, @x - 1)
      Curses.addstr(@vertical_char)
    end

    # right
    (@height - 2).times do |x|
      Curses.setpos(@y - 1 + x + 1, @x - 1 + @width - 1)
      Curses.addstr(@vertical_char)
    end
  end
end


if __FILE__ == $0
  Curses.init_screen

  x = 3
  y = 4
  height = 5
  width = 6

  Curses.addstr(">> height=#{height}, width=#{width}, y=#{y}, x=#{x}")

  room = Room.new(height, width, y, x)
  room.box
  room.draw

  Curses.refresh
  Curses.get_char
end

