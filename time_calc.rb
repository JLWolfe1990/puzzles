MINS_PER_DAY = (24 * 60).freeze

def assert(exp1, exp2)
  if exp1 == exp2
    return print '.'
  end

  puts 'F'
  puts "expecting: #{exp2} got: #{exp1}"
end

def convert_to_military(time_str)
  # todo
  if(time_str.match?(/12:[0123456789]{1,2} AM/))
    return "00:#{time_str[3..4]}"
  end

  if(time_str.match?(/PM/))
    hours = time_str[0..1].to_i
    hours = hours + 12 unless hours == 12
    minutes = time_str.match(/:[0123456789]{2}/)[0][1..2]
    return "#{hours}:#{minutes}"
  end

  time_str[0..4]
end

def add_minutes_to_military(mil_time_str, shift_time)
  if(shift_time < 0)
    shift_time = MINS_PER_DAY + shift_time
  end

  hours_str, mins_str = mil_time_str.split(":")

  add_hours = (shift_time / 60).to_i
  add_mins = shift_time % 60

  hours = hours_str.to_i + add_hours
  mins = mins_str.to_i

  sum_mins = add_mins + mins

  hours = hours + (sum_mins / 60).to_i
  hours = hours % 24
  mins = sum_mins % 60

  ("%02d" % hours) + ":" + ("%02d" % mins)
end

def print_twelve_hr_format(mil_time_str)
  hours_str, mins_str = mil_time_str.split(":")
  hours = hours_str.to_i
  mins = mins_str.to_i
  am_pm = "AM"

  am_pm = "PM" if hours >= 12
  hours = hours % 12 if hours > 12

  hours = 12 if hours == 0

  "#{"%02d" % hours}:#{"%02d" % mins} #{am_pm}"
end

def do_time_adjustment(time_str, shift_time)
  raise "invalid format" unless time_str.match?(/[012]{0,1}:[0123456789]{1,2} [AM|PM]/)

  mil_time_str = convert_to_military(time_str)
  mil_time_str = add_minutes_to_military(mil_time_str, shift_time)

  print_twelve_hr_format(mil_time_str)
end

assert(convert_to_military("12:00 AM"), "00:00")
assert(convert_to_military("12:00 PM"), "12:00")
assert(convert_to_military("4:12 PM"), "16:12")
assert(convert_to_military("11:59 PM"), "23:59")

assert(add_minutes_to_military("00:00", -120), "22:00")
assert(add_minutes_to_military("00:00", 120), "02:00")
assert(add_minutes_to_military("00:59", 5), "01:04")
assert(add_minutes_to_military("23:59", 6), "00:05")

assert(print_twelve_hr_format("00:00"), "12:00 AM")
assert(print_twelve_hr_format("02:00"), "02:00 AM")
assert(print_twelve_hr_format("12:00"), "12:00 PM")
assert(print_twelve_hr_format("14:00"), "02:00 PM")
assert(print_twelve_hr_format("00:05"), "12:05 AM")
assert(print_twelve_hr_format("23:59"), "11:59 PM")

assert(do_time_adjustment("12:00 AM", 120), "02:00 AM")
assert(do_time_adjustment("12:00 AM", 12 * 60), "12:00 PM")
assert(do_time_adjustment("11:59 PM", 6), "12:05 AM")
