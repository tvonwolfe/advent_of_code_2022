# frozen_string_literal: true

input = File.read('input')

def find_marker(string, window_size)
  start_window = 0
  end_window = window_size - 1

  while end_window < string.length
    window = string[start_window..end_window]
    break if window.chars.uniq.count == window_size

    start_window += 1
    end_window += 1
  end

  end_window + 1
end

puts find_marker(input, 4)
puts find_marker(input, 14)
