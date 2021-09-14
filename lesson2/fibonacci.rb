count = [0, 1]

while count[1] <= 100 do
  puts count[1]

  prev = count[1]
  nxt = count[0] + count[1]
  
  count[0] = prev
  count[1] = nxt
end
