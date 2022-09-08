#!/usr/bin/env ruby

class Position
  attr_accessor :y, :x

  def initialize(y, x)
    @y = y
    @x = x
  end

  def to_s
    "y = #{@y}, x = #{@x}"
  end
end

if __FILE__ == $0
end

