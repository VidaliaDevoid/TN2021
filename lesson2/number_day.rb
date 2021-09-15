puts "Day:"
day = gets.chomp.to_i

puts "Month:"
month = gets.chomp.to_i

puts "Year:"
year = gets.chomp.to_i

months = {
    january: 31,
    february: 28,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    july: 31,
    august: 31,
    september: 30,
    october: 31,
    november: 30,
    december: 31}

def leap_year?(year)
  (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0) 
end

months[:february] += 1 if leap_year?(year)
days = day

months.keys.each.with_index do |key, index|
  if index <= month -1
    days += months[key]
    index += 1
  end
end

puts days.to_i
