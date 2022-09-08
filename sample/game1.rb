#!/usr/bin/env ruby

require "curses"

require "./position"
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

class GameState
  def initialize(screen, player)
    @screen = screen
    @player = player
    @is_active = true

    Curses.curs_set(0)
    Curses.noecho
  end

  def tick
    @screen.clear
    @screen.set(@player.position, @player.to_ch)
    @screen.draw
#   @player.draw

    while @is_active do

      # player_action
      ch = player_input
      case ch
      when 'h' then
        if (@player.x - 1 >= @screen.min_x) then
          @player.x = @player.x - 1
        end
      when 'q' then
        @is_active = false
      end

      @screen.clear
      @screen.set(@player.position, @player.to_ch)
      @screen.draw
#     @player.draw
    end
  end

  def player_input
    Curses.get_char
  end
end


if __FILE__ == $0

  Curses.init_screen

  screen = Screen.new(Curses.lines, Curses.cols)
  map = Map.new(Curses.lines, Curses.cols)
  map.generate
  player = Player.new(Position.new(screen.max_y / 2, screen.max_x / 2))

  state = GameState.new(screen, player)
  state.tick

end

