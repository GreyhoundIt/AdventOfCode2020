# frozen_string_literal: true

require 'set'
require 'pry'

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

      puts 'Pairs'
      puts "numbers are #{number} and #{corresponding_number}"
      puts '-------'
      puts 'multiplied = '
      puts corresponding_number * number
      break # as we only need the first pair
    end
  end

  # we need to find 3 numbers in the list that add up to 2020 and then multiply them.
  # set a flag so we can exit when we have found the 3
  # go over the set and find the new remainder then go over the set again excluding the number we have in the main loop
  # take the number away from the running remainder and see if that is left in the set
  def find_triplets_and_multiples
    done = false
    set.each do |number|
      new_total = TOTAL - number
      break if done
      set.each do |number1|
        next if number1 == number

        corresponding_number = new_total - number1
        next unless set.include?(corresponding_number)

        puts '-------------********-------------'
        puts 'Triplets'
        puts "numbers are #{number1}, #{number} and #{corresponding_number}"
        puts '-------'
        puts 'multiplied = '
        puts corresponding_number * number * number1
        done = true
        break # as we only need the first triplets
      end
    end
  end

  # below is a better solution to the problem I found after my initial work I cant take credit for this but putting it
  # in for reference
  # this turns the set into an array of 2 elements we can then go over these as before
  def better_solution_to_multiples
    set.to_a.combination(2) do |number, number1|
      remainder = TOTAL - number - number1

      if set.include?(remainder)
        puts '------'
        puts remainder * number * number1
        break
      end
    end
  end
end

FindNumbers2020.new.find_pairs_and_multiples
FindNumbers2020.new.find_triplets_and_multiples
FindNumbers2020.new.better_solution_to_multiples
