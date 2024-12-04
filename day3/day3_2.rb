#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/3#part2

script_dir = File.dirname(__FILE__)

enabled = true

result = File.foreach(File.join(script_dir, "input.txt")).reduce(0) do |sum, line|
  line.scan(/(do)\(\)|(don't)\(\)|mul\((\d{1,3}),(\d{1,3})\)/).reduce(sum) do |s, (on, off, x, y)|
    result = s

    if on
      enabled = true
    end

    if off
      enabled = false
    end

    if enabled
      result = s + (x.to_i * y.to_i)
    end

    result
  end
end

puts "total: #{result}"
