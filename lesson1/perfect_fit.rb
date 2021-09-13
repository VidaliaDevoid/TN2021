puts "Hi! What's your name?"
name = gets.chomp

puts "What's your height, #{name}?"
height = gets.chomp.to_i

perfect_fit = (height - 110)*1.15

result = "#{name}, your weight value is #{perfect_fit}."
result += "You are ok :)" if perfect_fit < 0

puts result
