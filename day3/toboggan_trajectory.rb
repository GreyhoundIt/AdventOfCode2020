# frozen_string_literal: true

class TobogganTrajectory
  attr_reader :lines
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @lines = input.split("\n").map(&:chars)
  end

  def beginners_slope
    traverse_slope(across: 3, down: 1)
  end

  def multi_slope
    routes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    routes.map { |vx, vy| traverse_slope(across: vx, down: vy) }.inject(:*)
  end

  private

  def traverse_slope(across:, down:)
    x = 0
    y = 0
    trees = 0
    while y < map_height
      trees += 1 if tree?(at_point(x, y))
      y += down
      x += across
    end
    trees
  end

  def map_height
    lines.length
  end

  def tree?(char)
    char == '#'
  end

  def at_point(x, y)
    lines[y][x % lines.first.length]
  end
end

puts TobogganTrajectory.new.beginners_slope
puts TobogganTrajectory.new.multi_slope
