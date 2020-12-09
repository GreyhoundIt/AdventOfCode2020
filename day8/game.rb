
require 'pry'
require 'set'

# attr_accessor :rules
class Game
  attr_accessor :rules
  def initialize
    file_path  = File.expand_path('input.txt', __dir__)
    input      = File.read(file_path)
    @rules = input.split(/\n/)
  end

  def run
    pointer = 0
    accumilator = 0
    visited_lines = Set.new

    while true
      if visited_lines.include?(pointer)
        puts accumilator
        puts visited_lines
        exit
      end
      puts pointer
      visited_lines.add(pointer)
      command, argument = rules[pointer].split
      argument = argument.to_i

      case command
        when "acc"
          accumilator += argument
        when "jmp"
          pointer += argument -1
        end
      pointer += 1
    end

  end
end

Game.new.run