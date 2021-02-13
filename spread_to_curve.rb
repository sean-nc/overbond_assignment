require './utilities'

def spread_to_curve(file_path)
  results = ['bond,spread_to_curve']

  corporate_bonds, government_bonds = Utilities::CSVFile.new(file_path).parse

  term_yield_hash = government_bonds.map { |row| [row['term'].to_f, row['yield'].to_f] }.to_h

  corporate_bonds.each do |corporate_bond|
    b = Utilities::LinearInterpolation.new(term_yield_hash, corporate_bond['term'].to_f).call
    result = corporate_bond['yield'].to_f - b

    results << "#{corporate_bond['bond']},#{'%0.2f' % result}%"
  end

  results
end
