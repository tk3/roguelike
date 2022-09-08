#!/usr/bin/env ruby

require "curses"

require "./position"
require "./array2d"
require "./screen"
require "./map"
require "./player"

class GameState
  def initialize(screen, player)
    @screen = screen
    @player = player
    @is_active = true

    Curses.curs_set(0)
    Curses.noecho
  end

  def tick

    map = Map.new(@screen.max_y, @screen.max_x)
    map.generate

    @screen.clear
    @screen.insert(map.to_array2d, 0, 0)
    @screen.set(@player.position, @player.to_ch)
    @screen.draw

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
      @screen.insert(map.to_array2d, 0, 0)
      @screen.set(@player.position, @player.to_ch)
      @screen.draw
    end
  end

  def player_input
    Curses.get_char
  end
end


if __FILE__ == $0

  Curses.init_screen

  screen = Screen.new(Curses.lines, Curses.cols)
  player = Player.new(Position.new(screen.max_y / 2, screen.max_x / 2))

  state = GameState.new(screen, player)
  state.tick

end

