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
    @screen.set_by_position(@player.position, @player.to_ch)
    draw_screen

    while @is_active do
      # player_action
      ch = player_input
      case ch
      when 'h' then
        player_try_move(@player, 0, -1, map)
      when 'l' then
        player_try_move(@player, 0, 1, map)
      when 'k' then
        player_try_move(@player, -1, 0, map)
      when 'j' then
        player_try_move(@player, 1, 0, map)
      when 'q' then
        @is_active = false
      end

      @screen.clear
      @screen.insert(map.to_array2d, 0, 0)
      @screen.set_by_position(@player.position, @player.to_ch)
      draw_screen
    end
  end

  def player_try_move(player, y, x, map)
    y_move = player.y + y
    x_move = player.x + x
    if (x_move < map.min_x || y_move < map.min_y || x_move >= map.max_x || y_move >= map.max_y) then
      return
    end
    if map.get(y_move, x_move) == TileType::WALL then
      return
    end
    player.y = player.y + y
    player.x = player.x + x
  end

  def player_input
    Curses.get_char
  end

  def draw_screen
    Curses.erase
    @screen.grid.each_index do |index|
      Curses.setpos(index, 0)
      Curses.addstr(@screen.grid[index].join)
    end
    Curses.refresh
  end
end


if __FILE__ == $0
  Curses.init_screen

  screen = Screen.new(Curses.lines, Curses.cols)
  player = Player.new(Position.new(screen.max_y / 2, screen.max_x / 2))

  state = GameState.new(screen, player)
  state.tick
end

