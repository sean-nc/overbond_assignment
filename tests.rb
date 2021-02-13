require './utilities'
require './spread_to_benchmark'
require './spread_to_curve'

def two_decimals(float)
  ('%.2f' % float).to_f
end

def assert(value)
  return if value

  raise 'Expected true got false => see trace for error line'
end

def assert_equal(given, expected)
  return unless given != expected

  raise "Was not equal, expect: #{expected}, actually got: #{given} => see trace for error line"
end

# check that parsed correctly
corporate_bonds, government_bonds = Utilities::CSVFile.new('test_csvs/test1.csv').parse\

# correct count for both corporate and government bonds
assert_equal(corporate_bonds.count, 4)
assert_equal(government_bonds.count, 5)

# correct values in each bond type
assert(corporate_bonds.all? { |bond| bond['type'] == 'corporate' })
assert(government_bonds.all? { |bond| bond['type'] == 'government' })

# check that linear interpolation is being applied correctly
# took examples from the web

# example: 1
given_value = 2.0
expected_value = 4.5

x_y_hash = {
  1.0 => 4.0,
  3.0 => 5.0
}

found_value = two_decimals(Utilities::LinearInterpolation.new(x_y_hash, given_value).call)

assert_equal(found_value, expected_value)

# example: 2
given_value = 23.3
expected_value = 45.82

x_y_hash = {
  20.1 => 32.2,
  30.2 => 75.2
}

found_value = two_decimals(Utilities::LinearInterpolation.new(x_y_hash, given_value).call)

assert_equal(found_value, expected_value)

# example: 3
given_value = 108
expected_value = 41.43

x_y_hash = {
  99.123 => 44.23,
  201.32 => 12
}

found_value = two_decimals(Utilities::LinearInterpolation.new(x_y_hash, given_value).call)

assert_equal(found_value, expected_value)

# test on data given by overbond
# spread_to_benchmark test
actual_value = spread_to_benchmark('test_csvs/test2.csv')
expected_value = ['bond,benchmark,spread_to_benchmark','C1,G1,1.60%']
assert_equal(expected_value, actual_value)

# spread_to_curve test
actual_value = spread_to_curve('test_csvs/test3.csv')
expected_value = ['bond,spread_to_curve','C1,1.22%','C2,2.98%']
assert_equal(expected_value, actual_value)

puts 'All tests passed'
