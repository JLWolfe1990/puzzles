class CodeTestException < Exception; end

# driver method
def print_multiples(arr)
  puts find_multiples(arr).join(" ")
end

def find_multiples(arr)
  sorted = arr.sort

  result = []
  last_int = nil

  sorted.each do |int|
    if last_int == nil
      last_int = int
      next
    end

    if last_int == int
      result << int
    else
      last_int = int
    end
  end

  result.uniq
end

raise CodeTestException unless find_multiples([0, 1, 1, 2, 3, 2]) == [1, 2]
raise CodeTestException unless find_multiples([1, 1, 2, 3, 2]) == [1, 2]
raise CodeTestException unless find_multiples([1, 1, 1, 2, 3, 2]) == [1, 2]
raise CodeTestException unless find_multiples([]) == []
raise CodeTestException unless find_multiples([1, 2, 3]) == []

print_multiples([1, 1, 2, 3, 2])
