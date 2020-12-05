# frozen_string_literal: true

require 'pry'
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
    end
    seats_ids.sort!
    test_array = (seats_ids.first..seats_ids.last).to_a

    puts test_array - seats_ids
  end
end

AirlineSeats.new.part_1
AirlineSeats.new.find_seat
