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
    # top
    Curses.setpos(@top - 1, @left - 1)
    Curses.addstr(@horizontal_char * @width)

    # bottom
    Curses.setpos(@top - 1 + @height - 1, @left - 1)
    Curses.addstr(@horizontal_char * @width)

    # left
    Curses.setpos(@top - 1, @left - 1)
    (@height - 2).times do |y|
      Curses.setpos(@top - 1 + y + 1, @left - 1)
      Curses.addstr(@vertical_char)
    end

    # right
    Curses.setpos(@top - 1, @left - 1)
    (@height - 2).times do |x|
      Curses.setpos(@top - 1 + x + 1, @left - 1 + @width - 1)
      Curses.addstr(@vertical_char)
    end
  end
end


if __FILE__ == $0
  Curses.init_screen

  top = 3
  left = 4
  height = 5
  width = 6

  Curses.addstr(">> top=#{top}, left=#{left}, height=#{height}, width=#{width}")

  room = Room.new(height, width, top, left)
  room.box
  room.draw

  Curses.refresh
  Curses.get_char
end

