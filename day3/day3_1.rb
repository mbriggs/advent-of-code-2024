#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/3

script_dir = File.dirname(__FILE__)

result = File.foreach(File.join(script_dir, "input.txt")).reduce(0) do |sum, line|
  line.scan(/mul\((\d{1,3}),(\d{1,3})\)/).reduce(sum) do |s, (x, y)|
    s + (x.to_i * y.to_i)
  end
end

puts "total: #{result}"
