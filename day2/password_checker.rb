require 'pry'

class PasswordChecker
  attr_reader :lines
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @lines = input.split("\n")
  end

  def count
    sum = 0
    @lines.each do |line|
      array = line.split
      letter = array[1].tr(':', '')
      password_letters = array[2].split('')
      password_letter_count = array[0].split('-')
      min_count = password_letter_count[0].to_i
      max_count = password_letter_count[1].to_i
      sum += 1 if (password_letters.count(letter).to_i >= min_count) && (password_letters.count(letter) <= max_count)
    end
    puts sum
  end

  def count_v2
    sum = 0
    @lines.each do |line|
      array = line.split
      letter = array[1].tr(':', '')
      password_letters = array[2].split('')
      password_letter_count = array[0].split('-')
      position_1 = password_letters[password_letter_count[0].to_i - 1]
      position_2 = password_letters[password_letter_count[1].to_i - 1]

      sum += 1 if position_1.count(letter) + position_2.count(letter) == 1
    end
    puts sum
  end
end
PasswordChecker.new.count
PasswordChecker.new.count_v2
