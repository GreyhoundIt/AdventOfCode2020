
require 'pry'
require 'set'

# attr_accessor :rules
class Luggage
  def initialize
    file_path  = File.expand_path('input.txt', __dir__)
    input      = File.read(file_path)
    @rules = input.split(/\n/)
  end

  def part_1
    parent_bag = Hash.new { |hash, key| hash[key] = Array.new }
    @rules.each do | rule |
      parent, contain = rule.match(/(\w+ \w+) bags contain (.*)\./)[1..2]

      children = contain.split(",")
      .map { |child| child.match(/(\w+ \w+) bag/)[1] }
      .compact

      children.each do |child|
        parent_bag[child] << parent
      end

      bag_colours = Set.new
      queue = ["shiny gold"]
      
      while queue.any?
        child = queue.shift
      
        parent_bag[child].each do |parent|
          bag_colours.add(parent)
          queue << parent
        end
      end
      
      puts bag_colours.size


    end
  end

end
Luggage.new.part_1