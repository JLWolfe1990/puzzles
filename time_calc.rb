MINS_PER_DAY = (24 * 60).freeze

def assert(exp1, exp2)
  if exp1 == exp2
    return print '.'
  end

  puts 'F'
  puts "expecting: #{exp2} got: #{exp1}"
end

def convert_to_military(time_str)
  return "00:#{time_str[3..4]}" if(time_str.match?(/12:[0123456789]{1,2} AM/))

  if(time_str.match?(/PM/))
    hours = time_str[0..1].to_i
    hours = hours + 12 unless hours == 12
    minutes = time_str.match(/:[0123456789]{2}/)[0][1..2]
    return "#{hours}:#{minutes}"
  end

  time_str[0..4]
end

def add_minutes_to_military(mil_time_str, shift_time)
  shift_time = MINS_PER_DAY + shift_time if(shift_time < 0)

  hours, mins = mil_time_str.split(":").map(&:to_i)

  add_hours_from_shift = (shift_time / 60).to_i
  add_mins_from_shift = shift_time % 60

  sum_mins = add_mins_from_shift + mins

  hours = (hours + add_hours_from_shift + (sum_mins / 60).to_i)

  ("%02d" % (hours % 24)) + ":" + ("%02d" % (sum_mins % 60))
end

def print_twelve_hr_format(mil_time_str)
  hours, mins = mil_time_str.split(":").map(&:to_i)
  am_pm = "AM"

  am_pm = "PM" if hours >= 12
  hours = hours % 12 if hours > 12

  hours = 12 if hours == 0

  "#{"%02d" % hours}:#{"%02d" % mins} #{am_pm}"
end

def do_time_adjustment(time_str, shift_time)
  raise "invalid format" unless time_str.match?(/[012]{0,1}:[0123456789]{1,2} [AM|PM]/) || !shift_time.is_a?(Integer)

  mil_time_str = convert_to_military(time_str)
  adjusted_mil_time_str = add_minutes_to_military(mil_time_str, shift_time)

  print_twelve_hr_format(adjusted_mil_time_str)
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
assert(do_time_adjustment("12:00 AM", 96 * 60 + 5), "12:05 AM")
