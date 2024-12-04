#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/1#part2

list1 = []
list2_freq = Hash.new(0)

File.foreach("day1_data.txt") do |line|
  id1, id2 = line.split
  list1 << id1.to_i
  list2_freq[id2.to_i] += 1
end

total = list1.reduce(0) do |sum, id|
  sum + (id * list2_freq[id])
end

puts "similarity: #{total}"
