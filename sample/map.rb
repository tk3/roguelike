#!/usr/bin/env ruby

require "curses"
require "./array2d"

module TileType
  WALL = 1
  FLOOR = 2
end

class Map < Array2d
  def initialize(y, x, initial_val = '')
    super(y, x, initial_val)
  end

  def generate
    (@min_x...@max_x).each do |x|
      @grid[@min_y][x] = TileType::WALL
      @grid[@max_y - 1][x] = TileType::WALL
    end

    (@min_y...@max_y).each do |y|
      @grid[y][@min_x] = TileType::WALL
      @grid[y][@max_x - 1] = TileType::WALL
    end

    r = Random.new()
    (0...400).each do |i|
      y = r.rand(@max_y)
      x = r.rand(@max_x)
      @grid[y][x] = TileType::WALL
    end
  end

  def get(position)
    @grid[position.y][position.x]
  end

  def set(position, ch)
    @grid[position.y][position.x] = ch
  end

  def draw
    Curses.erase
    @grid.each_index do |y|
      @grid[y].each_index do |x|
        Curses.setpos(y, x)
        ch = case @grid[y][x]
             when TileType::FLOOR
               "."
             when TileType::WALL
               "#"
             else
               " "
             end
        Curses.addch(ch)
      end
    end
    Curses.refresh
  end

  def to_array2d
    new_grid = Array2d.new(@max_y, @max_x, @initial_val)

    (@min_y...@max_y).each do |y|
      (@min_x...@max_x).each do |x|
        new_grid.set(y, x, case @grid[y][x]
                           when TileType::FLOOR
                             "."
                           when TileType::WALL
                             "#"
                           else
                             " "
                           end)
      end
    end
    new_grid
  end

  def copy
    tmp = Marshal.dump(self)
    Marshal.load(tmp)
  end
end

if __FILE__ == $0

  Curses.init_screen

  map = Map.new(Curses.lines, Curses.cols)
  map.generate
  map.draw

  Curses.get_char
end

