#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/4

## Matrix
script_dir = File.dirname(__FILE__)
matrix = File.foreach(File.join(script_dir, "input.txt")).map do |line|
  line.chomp.chars
end

# pre-compute bounds for perf (... excludes end number)
rows_i = (0...matrix.length)
cols_i = (0...matrix.first.length)

## Directions
dirs = []

# handle permutations of base set of directions to handle backwards and all
# diagonals.
[
  [1, 0], # horizontal
  [0, 1], # vertical
  [1, 1] # diagonal
].each do |x, y|
  dirs << [x, y] # base

  # x permutation if needed
  if x != 0
    dirs << [-x, y]
  end

  # y permutation if needed
  if y != 0
    dirs << [x, -y]
  end

  # y, y permutation if needed
  if x != 0 && y != 0
    dirs << [-x, -y]
  end
end

## solve
found = 0

# iterate each position in matrix
rows_i.each do |ri|
  cols_i.each do |ci|
    # iterate each vector
    dirs.each do |dx, dy|
      # bounds check
      dist = 3 # X (current pos = 0) + M + A + S

      if !rows_i.cover?(ri + (dist * dx))
        next
      end

      if !cols_i.cover?(ci + (dist * dy))
        next
      end

      # build word
      word = (0..dist).map do |n|
        x = ri + (n * dx)
        y = ci + (n * dy)

        matrix[x][y]
      end

      # check
      if word.join == "XMAS"
        found += 1
      end
    end
  end
end

puts "Found: #{found}"
