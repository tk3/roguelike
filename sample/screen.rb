#!/usr/bin/env ruby

require "./position"
require "./array2d"

class Screen < Array2d
  def initialize(y, x, initial_val = '')
    super(y, x, initial_val)
  end

  def clear
    @grid = Array.new(@max_y) { Array.new(@max_x, ' ') }
  end

  def draw
    @grid.each_index do |index|
      puts @grid[index].join
    end
  end

  def copy
    tmp = Marshal.dump(self)
    Marshal.load(tmp)
  end
end

if __FILE__ == $0
  screen1 = Screen.new(3, 3, ".")
  screen1_copy = screen1.copy

# screen1.draw
  screen1_copy.set(1, 1, '@')
  screen1_copy.draw
end

