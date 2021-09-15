alphabet = ('a'..'z').to_a;
vowels = ['a' ,'e' ,'i' ,'o' ,'u' ,'y'];
result = [];

alphabet.each do |a|
  vowels.each do |v|
    if a == v
      result << v;
    end
  end
end

puts result
