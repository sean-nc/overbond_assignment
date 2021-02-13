require 'csv'

module Utilities
  class CSVFile
    attr_reader :file_path

    def initialize(file_path)
      @file_path = file_path
    end

    def parse
      rows = CSV.parse(File.read(file_path), headers: true)

      corporate_bonds = []
      government_bonds = []

      rows.each do |row|
        row['type'] == 'corporate' ? corporate_bonds << row.to_h : government_bonds << row.to_h
      end

      [corporate_bonds, government_bonds]
    end
  end

  class Terms
    def self.clean(term)
      term.delete("^0-9\.").to_f
    end

    def self.compare(term1, term2)
      terms = [clean(term1), clean(term2)].sort
      terms[-1] - terms[0]
    end
  end

  class LinearInterpolation
    attr_reader :x, :x1, :x2, :y1, :y2

    def initialize(term_yield_hash, x)
      @x = x
      @x1 = closest_below(term_yield_hash.keys)
      @x2 = closest_above(term_yield_hash.keys)

      @y1 = term_yield_hash[x1]
      @y2 = term_yield_hash[x2]
    end

    def closest_below(arr)
      closest = nil
      difference = nil

      arr.each do |a|
        next if a > x

        new_difference = x - a

        if difference.nil?
          closest = a
          difference = new_difference
          next
        end

        if new_difference < difference
          difference = new_difference
          closest = a
        end
      end

      closest.to_f
    end

    def closest_above(arr)
      closest = nil
      difference = nil

      arr.each do |a|
        next if a < x

        new_difference = a - x

        if difference.nil?
          closest = a
          difference = new_difference
          next
        end

        if new_difference < difference
          difference = new_difference
          closest = a
        end
      end

      closest.to_f
    end

    def call
      y1 + ((x - x1) / (x2 - x1)) * (y2 - y1)
    end
  end
end