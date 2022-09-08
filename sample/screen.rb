#!/usr/bin/env ruby

require "curses"
require "./position"
require "./array2d"

class Screen < Array2d
  def initialize(y, x, initial_val = '')
    super(y, x, initial_val)
  end

  def get(position)
    @grid[position.y][position.x]
  end

  def set(position, ch)
    @grid[position.y][position.x] = ch
  end

  def clear
    @grid = Array.new(@max_y) { Array.new(@max_x, ' ') }
  end

  def draw
    Curses.erase
    @grid.each_index do |index|
      Curses.setpos(index, 0)
      Curses.addstr(@grid[index].join)
    end
    Curses.refresh
  end

  def copy
    tmp = Marshal.dump(self)
    Marshal.load(tmp)
  end
end

if __FILE__ == $0
  Curses.init_screen

  screen1 = Screen.new(3, 3, ".")
  screen1_copy = screen1.copy

# screen1.draw
  screen1_copy.set(Position.new(1,1), '@')
  screen1_copy.draw

  Curses.getch
end

