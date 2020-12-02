# frozen_string_literal: true

require 'pry'

class PasswordChecker
  attr_reader :lines
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @lines = input.split("\n")
  end

  def count
    puts @lines.count { |line|
      array = line.split
      letter = array[1].tr(':', '')
      password_letters = array[2].split('')
      min_count, max_count = array[0].split('-').map(&:to_i)

      (min_count..max_count).cover?(password_letters.count(letter))
    }
  end

  def count_v2
    puts @lines.count { |line|
      array = line.split
      letter = array[1].tr(':', '')
      password_letters = array[2].split('')
      password_letter_count = array[0].split('-')
      position_1 = password_letters[password_letter_count[0].to_i - 1]
      position_2 = password_letters[password_letter_count[1].to_i - 1]

      position_1.count(letter) + position_2.count(letter) == 1
    }
  end
end
PasswordChecker.new.count
PasswordChecker.new.count_v2
