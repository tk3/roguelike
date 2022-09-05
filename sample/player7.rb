#!/usr/bin/env ruby

require "curses"

class Player
  PLAYER_CHR = "@"

  def initialize(y = 0, x = 0)
    @y = y
    @x = x
  end

  def move_upper
    if (@y - 1 >= 0) then
      @y = @y - 1
    end
  end

  def move_bottom
    if (@y + 1 < Curses.lines) then
      @y = @y + 1
    end
  end

  def move_left
    if (@x - 1 >= 0) then
      @x = @x - 1
    end
  end

  def move_right
    if (@x + 1 < Curses.cols) then
      @x = @x + 1
    end
  end

  def draw
    Curses.setpos(@y, @x)
    Curses.addstr(PLAYER_CHR)
  end

end


if __FILE__ == $0

  Curses.init_screen

  player = Player.new(Curses.lines / 2, Curses.cols / 2 - (Player::PLAYER_CHR.length / 2))
  player.draw
  Curses.refresh

  Curses.curs_set(0)
  Curses.noecho

  while true do
    ch = Curses.getch

    Curses.erase

    case ch
    when 'h' then
      player.move_left
    when 'l' then
      player.move_right
    when 'j' then
      player.move_bottom
    when 'k' then
      player.move_upper
    end

    player.draw

    Curses.refresh
  end

end


