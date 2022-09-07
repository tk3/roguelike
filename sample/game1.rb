#!/usr/bin/env ruby

require "curses"

require 'logger'

logger = Logger.new('logfile.log')


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
    Curses.erase
    @grid.each_index do |index|
      Curses.setpos(index, 0)
      Curses.addstr(@grid[index].join)
    end
  end
end

def debug(s)
  Curses.setpos(0, 0)
  Curses.addstr(s)
end

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
    "@"
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
    player_prev_position = @player.position.clone
    prev_tile = @screen.get(player_prev_position)

    @screen.set(@player.position, @player.to_ch)
    @screen.draw

    while @is_active do

      ch = player_input

      player_prev_position = @player.position.clone
      prev_tile = @screen.get(player_prev_position)

      player_action(ch)
      break  unless @is_active 

      @screen.set(player_prev_position, prev_tile)
      @screen.set(@player.position, @player.to_ch)
      @screen.draw
    end
  end

  def player_input
    Curses.get_char
  end

  def player_action(ch)
    case ch
    when 'h' then
      if (@player.x - 1 >= @screen.min_x) then
        @player.x = @player.x - 1
      end
    when 'q' then
      @is_active = false
    end
  end
end

class Position
  attr_accessor :y, :x

  def initialize(y, x)
    @y = y
    @x = x
  end
end

    logger << "add message"

if __FILE__ == $0

  Curses.init_screen

  screen = Screen.new(Curses.lines, Curses.cols)
  player = Player.new(Position.new(screen.max_y / 2, screen.max_x / 2))

  state = GameState.new(screen, player)
  state.tick

end

