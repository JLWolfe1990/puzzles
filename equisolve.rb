# lowest positive integers where the characters add up to 10 and include a 7

index = 3
caught = 0

while(caught < 10) do
  chars = index.to_s.scan(/\w/)

  if chars.map(&:to_i).sum + 7 == 10
    caught += 1
    puts (chars << '7').join
  end

  index += 1
end
