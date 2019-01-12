class CodeTestException < Exception; end

# driver method
def phone_format(s)
  string = s.to_s.gsub(/[^0-9]/, '') # force input to string
  string_length = string.length

  # ensure that the return type stays consistent and make sure that there isn't
  # one digit by itself as specified by the API
  return string unless string_length > 2

  format_phone_string(string, string_length)
end

private

def format_phone_string(string, string_length)
  formatted_string = ""
  early_dash = string_length % 3 == 1
  skip_dash = false

  # start index at 1 for easier comprehension
  i = 0

  string.each_char do |char|
    formatted_string << char
    break if i == string_length

    i += 1

    if early_dash && (i == string_length - 2)
      # jump to the end and break

      formatted_string << '-'
      skip_dash = true
    end

    formatted_string << '-' if i % 3 == 0 && !skip_dash
  end

  formatted_string
end

raise CodeTestException unless phone_format("(+1) 888 33x19") == "188-833-19"
raise CodeTestException unless phone_format("555 123 1234") == "555-123-12-34"
raise CodeTestException unless phone_format("(+1)") == '1'
raise CodeTestException unless phone_format(nil) == ""
raise CodeTestException unless phone_format("") == ""
