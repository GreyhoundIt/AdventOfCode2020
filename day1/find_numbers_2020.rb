# frozen_string_literal: true

require 'set'

# class to find the two numbers in the data tha when added together = 2020 and what the value of them multiplied is
class FindNumbers2020
  TOTAL = 2020
  attr_reader :set
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @set = input.split("\n").map(&:to_i).to_set
  end

  # go through the set with the current number minus TOTAL this will give the corresponding number to make the total
  # if the corresponding number is contained in the set then give the two numbers
  # and the total of the numbers multiplied
  def find_pairs_and_multiples
    set.each do |number|
      corresponding_number = TOTAL - number
      next unless set.include?(corresponding_number)

      puts "numbers are #{number} and #{corresponding_number}"
      puts '-------'
      puts corresponding_number * number
      break # as we only need the first pair
    end
  end
end

FindNumbers2020.new.find_pairs_and_multiples
