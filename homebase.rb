def assert(expr1, expr2)
  return puts "F: I was expecting |#{expr2}| but I got |#{expr1}|" unless expr1 == expr2

  puts "."
end

def reverse_char(str)
  reverse_str = ""

  return reverse_str if str.nil?

  str.each_char do |char|
    reverse_str = char + reverse_str
  end

  reverse_str
end

assert(reverse_char("Happy New Year"), "Happy New Year".reverse)
assert(reverse_char("cow"), "woc")
assert(reverse_char(""), "")
assert(reverse_char(nil), "")

def reverse_word_order(words_str)
  return "" if words_str.nil?

  words_str.split.inject("") { |memory, word| memory.length == 0 ? word : "#{word} #{memory}" }
end

assert(reverse_word_order("Happy New Year"), "Year New Happy")
assert(reverse_word_order(nil), "")
assert(reverse_word_order(""), "")


def reverse_word_in_place(word_str)
  return "" if word_str.nil?

  word_str.split.inject("") { |memory, word| memory.length == 0 ? reverse_char(word) : "#{memory} #{reverse_char(word)}" }
end

assert(reverse_word_in_place("Happy New Year"), "yppaH weN raeY")
assert(reverse_word_in_place(nil), "")
assert(reverse_word_in_place(""), "")

def recursive_reverse_char(remaining_str)
  return "" if remaining_str.nil? || remaining_str.length == 0

  remaining_str[-1] + recursive_reverse_char(remaining_str[0...-1])
end

assert(recursive_reverse_char("cow"), "woc")
assert(recursive_reverse_char(nil), "")
assert(recursive_reverse_char(""), "")
