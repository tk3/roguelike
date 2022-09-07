#!/usr/bin/env ruby

require "curses"

class Screen
  attr_reader :max_y, :max_x
  attr_reader :min_y, :min_x

  def initialize(y, x)
    @max_y = y
    @max_x = x
    @min_y = 0
    @min_x = 0
    @grid = Array.new(@max_y) { Array.new(@max_x, '.') }
  end

  def get(position)
    @grid[position.y][position.x]
  end

  def set(position, ch)
    @grid[position.y][position.x] = ch
  end

  def draw
    @grid.each_index do |index|
      puts @grid[index].join
    end
  end
end

if __FILE__ == $0

  require "pp"

end

