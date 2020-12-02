# frozen_string_literal: true

require 'pry'

class PasswordChecker
  attr_reader :lines
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @lines = input.split("\n")
  end

  def part1
    puts @lines.count { |line|
      array = line.split
      letter = array[1].tr(':', '')
      password_letters = array[2].split('')
      min_count, max_count = array[0].split('-').map(&:to_i)

      (min_count..max_count).cover?(password_letters.count(letter))
    }
  end

  def part1_alternative
   puts @lines.count { |line|
    m = line.match(/^(?<from>\d+)-(?<to>\d+) (?<char>.): (?<password>.*)$/)
    (m[:from].to_i..m[:to].to_i).cover?(m[:password].count(m[:char]))
  }
  end

  def part2
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

  def part2_alternative
    puts @lines.count { |line|
      m = line.match(/^(?<position_1>\d+)-(?<position_2>\d+) (?<char>.): (?<password>.*)$/)
      (m[:password][m[:position_1].to_i - 1]).count(m[:char]) + (m[:password][m[:position_2].to_i - 1]).count(m[:char]) == 1
    }
  end
end

PasswordChecker.new.part1
PasswordChecker.new.part1_alternative
PasswordChecker.new.part2
PasswordChecker.new.part2_alternative
