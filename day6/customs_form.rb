# frozen_string_literal: true

require 'pry'
require 'set'
class CustomsForm
  def initialize
    file_path  = File.expand_path('input.txt', __dir__)
    input      = File.read(file_path)
    @documents = input.split(/\n{2,}/)
  end

  #find the number of unique answers per party and add them up
  def part_1
    @documents.map do |form|
      party(form)
    end.sum
  end

  def party(forms)
    Set.new(forms.delete("\n").chars).count
  end

  # find the number of answers everyone in the party answers and add them up
  def part_2
    @documents.map do |party_forms|
      all_unique_answers = party_forms.gsub(/\s+/, '').chars.uniq

      forms = party_forms.split(/\n/)

      all_unique_answers.count do |answer|
        forms.all? { |form_answer| form_answer.include?(answer) }
      end
    end.sum
  end
end

puts CustomsForm.new.part_1
puts '-----'
puts CustomsForm.new.part_2
