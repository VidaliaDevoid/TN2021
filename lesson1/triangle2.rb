puts "Side a:"
a = gets.chomp.to_f

puts "Side b:"
b = gets.chomp.to_f

puts "Side c:"
c = gets.chomp.to_f

arr = [a, b, c]
a,b,c = arr.sort

if c**2 > a**2 + b**2
  puts 'right triangle'
elsif arr.uniq.count == 1
  puts 'isosceles and equilateral triangle'
elsif arr.uniq.count < 3
  puts 'equilateral triangle'
end
