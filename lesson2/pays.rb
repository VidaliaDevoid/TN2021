name = ''
sum = 0
positions = {}

loop do
  puts 'Name:'
  name = gets.chomp

  break if name == 'stop'

  puts 'Price:'
  price = gets.chomp.to_f

  puts 'Count:'
  count = gets.chomp.to_f

  positions[name]= name
  positions[name] = {price: price, count: count}
end

puts '--Your values--'
puts positions

puts '--Result sum lines--'
positions.each do |name, attrs|
    result = attrs[:price]*attrs[:count]
    puts "#{name} ------> #{result}"
    sum += result
end

puts '--Total--'
puts sum
