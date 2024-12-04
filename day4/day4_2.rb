#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/4#part2

## Matrix
script_dir = File.dirname(__FILE__)
matrix = File.foreach(File.join(script_dir, "input.txt")).map do |line|
  line.chomp.chars
end

# pre-compute bounds for perf (... excludes end number)
rows_i = (0...matrix.length)
cols_i = (0...matrix.first.length)

## solve
found = 0

# dirs (only need down left / down right)
right = [1, -1]
left = [-1, -1]

# lambda because i need the rows closure and can't be bothered reworking
check = lambda { |ri, ci, dx, dy|
  # bounds check
  dist = 2 # M (current pos = 0) + A + S (or SAM)

  if !rows_i.cover?(ri + (dist * dx))
    return false
  end

  if !cols_i.cover?(ci + (dist * dy))
    return false
  end

  # build word
  word = (0..dist).map do |n|
    x = ri + (n * dx)
    y = ci + (n * dy)

    matrix[x][y]
  end

  word = word.join

  # check
  ["MAS", "SAM"].include?(word)
}

# iterate each position in matrix
rows_i.each do |ri|
  cols_i.each do |ci|
    r = check.call(ri, ci, *right)
    if !r
      next
    end

    l = check.call(ri + 2, ci, *left)

    if r & l
      found += 1
    end
  end
end

puts "Found: #{found}"
