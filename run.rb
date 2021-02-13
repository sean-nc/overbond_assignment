require './spread_to_benchmark'
require './spread_to_curve'

files = {}

Dir.glob('*.csv').each_with_index { |filename, i| files[i] = filename }

functions = {
  0 => 'spread_to_curve',
  1 => 'spread_to_benchmark'
}

file_num = -1

until files.keys.include?(file_num)
  puts 'select sample data (default: 0)'

  files.each do |k, v|
    puts "#{k}: #{v}"
  end

  file_num = gets.to_i
end

puts "You selected '#{files[file_num]}'\n\n"

function_num = -1

until functions.keys.include?(function_num)
  puts 'select sample data (default: 0)'

  functions.each do |k, v|
    puts "#{k}: #{v}"
  end

  function_num = gets.to_i
end

puts "You selected '#{functions[function_num]}'\n\n"

function_call = "#{functions[function_num]}('#{files[file_num]}')"

puts "calling #{function_call}\n\n"
results = instance_eval(function_call)

results.each { |line| puts line }
