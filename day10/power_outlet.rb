require 'pry'
class PowerOutlet
  attr_reader :jolts,:input
  def initialize
    file_path = File.expand_path('input.txt', __dir__)
    input     = File.read(file_path)
    @jolts = input.split("\n").map(&:to_i).sort
  end

  def part_1
    one_jump = 1
    three_jumps = 1
    jolts.each_with_index do |rating, index|
      one_jump += 1 if rating+1 == jolts[index+1]
      three_jumps += 1 if rating+3 == jolts[index+1]
    end
    puts one_jump * three_jumps
    #puts three_jumps
  end

end

PowerOutlet.new.part_1
#puts ComputerPort.new.part_2
