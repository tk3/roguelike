#!/usr/bin/env ruby

require "curses"

require "./position"
require "./array2d"
require "./screen"
require "./map"

class Actor
  def move(position, input, screen)
  end
end

class Player < Actor
  attr_reader :position

  def initialize(position)
    @position = position
  end

  def x
    @position.x
  end

  def x=(value)
    @position.x = value
  end

  def y
    @position.y
  end

  def y=(value)
    @position.y = value
  end

  def to_ch
    '@'
  end

  def draw
    Curses.setpos(@position.y, @position.x)
    Curses.addch(self.to_ch)
  end
end

if __FILE__ == $0

  Curses.init_screen

  player = Player.new(Position.new(screen.max_y / 2, screen.max_x / 2))

end

