require './spread_to_benchmark'
require './spread_to_curve'

files = {}

Dir.glob('*.csv').each_with_index { |filename, i| files[i] = filename }

functions = {
  0 => 'spread_to_benchmark',
  1 => 'spread_to_curve'
}

file_num = -1

until files.keys.include?(file_num)
  puts "Enter the number of the data you'd like to select:\n"

  files.each do |k, v|
    puts "#{k}: #{v}#{' <- default' if k == 0}"
  end

  file_num = gets.to_i
end

puts "You selected '#{files[file_num]}'\n\n"

function_num = -1

until functions.keys.include?(function_num)
  puts "Enter the number of the function you'd like to select:\n"

  functions.each do |k, v|
    puts "#{k}: #{v}#{' <- default' if k == 0}"
  end

  function_num = gets.to_i
end

puts "You selected '#{functions[function_num]}'\n\n"

function_call = "#{functions[function_num]}('#{files[file_num]}')"

puts "calling #{function_call}\n\n"
results = instance_eval(function_call)

results.each { |line| puts line }
