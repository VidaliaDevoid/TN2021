puts "ax^2 + bx + c"
puts "a:"
a = gets.chomp.to_f

puts "b:"
b = gets.chomp.to_f

puts "c:"
c = gets.chomp.to_f

D = b**2 - 4*a*c

result = 
  if D > 0
    x1 = (-b + Math.sqrt(D))/(2*a)
    x2 = (-b - Math.sqrt(D))/(2*a)
    "#{x1} and #{x2}"
  elsif D == 0
    x1 = -b/(2*a)
    "#{x1}"
  else
    "the equation has no roots"
  end

  puts "The result of solving the equation: #{result}."
