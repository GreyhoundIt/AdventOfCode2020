# frozen_string_literal: true

require 'pry'
require 'set'
class AirlineSeats
  def initialize
    file_path  = File.expand_path('input.txt', __dir__)
    input      = File.read(file_path)
    @boarding_cards = input.split(/\n/)
    @rows = 127
    @columns = 7
  end

  def part_1
    seats_ids = @boarding_cards.map do |doc|
      find_seat_ids(doc.chars.take(7), doc.chars.drop(7))
    end
    puts seats_ids.max
  end

  def find_row(row_keys)
    range = [0, @rows]
    row_keys.map do |key|
      midpoint = (range[0] + range[1]) / 2
      range = if key == 'F'
                [range[0], midpoint]
              else
                [midpoint + 1, range[1]]
              end
    end
    range.uniq.first.to_i
  end

  def find_column(column_keys)
    range = [0, @columns]
    column_keys.map do |key|
      midpoint = (range[0] + range[1]) / 2
      range = if key == 'L'
                [range[0], midpoint]
              else
                [midpoint + 1, range[1]]
              end
    end
    range.uniq.first.to_i
  end

  def find_seat_ids(row_keys, column_keys)
    find_row(row_keys) * 8 + find_column(column_keys)
  end

  def find_seat
    seats_ids = @boarding_cards.map do |doc|
      find_seat_ids(doc.chars.take(7), doc.chars.drop(7))
    end.sort!

    test_array = (seats_ids.first..seats_ids.last).to_a

    puts test_array - seats_ids
  end

  #-----------------
  def part_1_second_attempt
    seats_ids = @boarding_cards.map do |doc|
      pos = find_position(doc.chars)
      pos[0] * 8 + pos[1]
    end
    puts seats_ids.max
  end

  def part_2_second_attempt
    seats_ids = @boarding_cards.map do |doc|
      pos = find_position(doc.chars)
      pos[0] * 8 + pos[1]
    end
    ids = Set.new(seats_ids)
    puts (ids.min..ids.max).find { |id|
      ids.include?(id - 1) && ids.include?(id + 1) && !ids.include?(id)
    }
  end

  def find_position(keys)
    row_min = 0
    row_max = @rows
    col_min = 0
    col_max = @columns
    keys.map do |key|
      row_midpoint = (row_min + row_max) / 2
      column_midpoint = (col_min + col_max) / 2
      case key
      when 'F'
        row_max = row_midpoint
      when 'B'
        row_min = row_midpoint + 1
      when 'L'
        col_max = column_midpoint
      when 'R'
        col_min = column_midpoint + 1
      end
    end

    [row_max, col_max]
  end
end

AirlineSeats.new.part_1
AirlineSeats.new.find_seat
puts '-----'
AirlineSeats.new.part_1_second_attempt
AirlineSeats.new.part_2_second_attempt
