require 'pry'
class ComputerPort
  attr_reader :transmission, :range
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @transmission = input.split("\n").map(&:to_i)
    @range = 25
  end

  def program
    transmission.each_cons(range + 1) do |x|
      number = x.last
      candidates = x[0..range]

      return number unless candidates.combination(2).any? {|z| z.sum == number}
    end
  end

  def part_2
    total = 144381670
    (0...transmission.length).each do |start_position|
      (start_position+1...transmission.length).each do |finish_position|
        range = transmission[start_position..finish_position]
        if range.sum == total
          return range.sort.first + range.sort.last
        end
      end
    end
  end

end

puts ComputerPort.new.program
puts ComputerPort.new.part_2
