#!/usr/bin/env ruby

require "curses"

class Array2d
  attr_reader :max_y, :max_x
  attr_reader :min_y, :min_x
  attr_reader :grid

  def initialize(y, x, initial_val = '')
    @initial_val = initial_val
    @max_y = y
    @max_x = x
    @min_y = 0
    @min_x = 0
    @grid = Array.new(@max_y) { Array.new(@max_x, @initial_val) }
  end

  def get(position)
    @grid[position.y][position.x]
  end

  def set(position, ch)
    @grid[position.y][position.x] = ch
  end

  def clear
    @grid = Array.new(@max_y) { Array.new(@max_x, @initial_val) }
  end

  def draw
    @grid.each_index do |index|
      puts @grid[index].join
    end
  end

  def insert(arr2d, y, x)
    (y...(arr2d.max_y + y)).each do |ay|
      (x...(arr2d.max_x + x)).each do |ax|
        puts ">> #{ay}, #{ax}"
        @grid[ay][ax] = arr2d.grid[ay - y][ax - x]
      end
    end
  end
end


if __FILE__ == $0

  arr1 = Array2d.new(5, 5, ".")
  arr2 = Array2d.new(5, 5, "#")
  arr1.insert(arr2, 0, 0)
  arr1.draw


end

