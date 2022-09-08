#!/usr/bin/env ruby

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

  def get(y, x)
    @grid[y][x]
  end

  def set(y, x, ch)
    @grid[y][x] = ch
  end

  def set_by_position(position, ch)
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
    max_y = if (arr2d.max_y + y) > @max_y
             @max_y
           else
            arr2d.max_y + y
           end
    max_x = if (arr2d.max_x + x) > @max_x
             @max_x
           else
            arr2d.max_x + x
           end
    (y...max_y).each do |ay|
      (x...max_x).each do |ax|
        @grid[ay][ax] = arr2d.grid[ay - y][ax - x]
      end
    end
  end
end


if __FILE__ == $0
  arr1 = Array2d.new(5, 5, ".")
  arr2 = Array2d.new(4, 4, "#")
  arr1.insert(arr2, 2, 2)
  arr1.draw
end

