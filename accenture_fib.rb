class CodeTestException < Exception; end

# driver method
def calc_fib(sum)
  return 1 if sum <= 1
  stop_val = sum / 2.0

  fib_arr = [1, 1]

  while fib_arr.sum < sum
    two_back = fib_arr[-2]

    next_fib = two_back + fib_arr[-1]

    puts next_fib
    if next_fib > stop_val
      puts 'here'
      fib_arr << stop_val

      puts fib_arr.length
      break
    else
      fib_arr << next_fib
    end
  end
end

puts calc_fib(10)
raise CodeTestException unless calc_fib(10) == 5
raise CodeTestException unless calc_fib(1) == 1
