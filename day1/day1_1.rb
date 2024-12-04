#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/1

list1 = []
list2 = []

File.foreach("day1_data.txt") do |line|
  id1, id2 = line.split
  list1 << id1.to_i
  list2 << id2.to_i
end

list1.sort!
list2.sort!

total = list1.zip(list2).reduce(0) do |sum, (id1, id2)|
  sum + (id1 - id2).abs
end

puts "total distance: #{total}"
