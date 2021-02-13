require './utilities'

def spread_to_benchmark(file_path)
  results = ['bond,benchmark,spread_to_benchmark']

  corporate_bonds, government_bonds = Utilities::CSVFile.new(file_path).parse

  corporate_bonds.each do |corporate_bond|
    difference = nil
    comparable_bond = nil

    government_bonds.each do |government_bond|
      break if difference&.zero?

      if difference.nil?
        comparable_bond = government_bond
        difference = Utilities::Terms.compare(corporate_bond['term'], government_bond['term'])
        next
      end

      new_difference = Utilities::Terms.compare(corporate_bond['term'], government_bond['term'])

      if new_difference < difference
        difference = new_difference
        comparable_bond = government_bond
      end
    end

    results << "#{corporate_bond['bond']},#{comparable_bond['bond']},#{'%0.2f' % (corporate_bond['yield'].to_f - comparable_bond['yield'].to_f)}%"
  end

  results
end
