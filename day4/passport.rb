# frozen_string_literal: true

require 'pry'

class Passport
  attr_reader :documents
  BIRTH_YEAR_RE = /^19[2-9]\d|200[012]$/.freeze
  ISSUE_YEAR_RE = /^20(1\d|20)$/.freeze
  EXP_YEAR_RE = /^20(2\d|30)$/.freeze
  PID_RE = /^[0-9]{9}$/.freeze
  HAIR_COLOR_RE = /^#[0-9a-f]{6}$/.freeze
  EYE_COLOR_RE = /^(amb|blu|brn|gry|grn|hzl|oth)$/.freeze

  def initialize
    file_path  = File.expand_path('input.txt', __dir__)
    input      = File.read(file_path)
    @documents = input.split(/\n{2,}/)
  end

  def process_all
    @documents.map do |document|
      process_document(document)
    end.count(true)
  end

  def make_document(document)
    fields = document.split(' ' || "\n").flat_map { |x| x.split(':').each_slice(2).collect { |k, v| [k, v] } }.to_h
  end

  def valid_feilds?(document)
    valid_keys = %w[byr iyr eyr hgt hcl ecl pid]
    return false unless valid_keys.all? { |k| document.key?(k) }

    return false unless birth_year_valid?(document['byr'])
    return false unless issue_year_valid?(document['iyr'])
    return false unless expiration_year_valid?(document['eyr'])
    return false unless passport_id_valid?(document['pid'])
    return false unless hair_color_valid?(document['hcl'])
    return false unless eye_color_valid?(document['ecl'])
    return false unless height_valid?(document['hgt'])

    true
  end

  def process_document(document)
    doc = make_document(document)
    valid_feilds?(doc)
  end

  def birth_year_valid?(birth_year)
    BIRTH_YEAR_RE.match?(birth_year)
  end

  def issue_year_valid?(issue_year)
    ISSUE_YEAR_RE.match?(issue_year)
  end

  def expiration_year_valid?(exp_year)
    EXP_YEAR_RE.match?(exp_year)
  end

  def passport_id_valid?(passport_id)
    PID_RE.match?(passport_id)
  end

  def hair_color_valid?(hair_colour)
    HAIR_COLOR_RE.match?(hair_colour)
  end

  def eye_color_valid?(eye_colour)
    EYE_COLOR_RE.match?(eye_colour)
  end

  def height_valid?(height)
    if /cm/.match?(height)
      (150..193).cover?(height.delete!('^0-9').to_i)
    else
      (59..76).cover?(height.delete!('^0-9').to_i)
    end
  end
end

puts Passport.new.process_all