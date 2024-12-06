#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/5#part2

class Ordering
  # ordering rules as a map of page => [pages it must be in front of]
  attr_reader :rules

  def initialize
    @rules = Hash.new { |h, k| h[k] = [] }
  end

  def cmp(a, b)
    if rules[b].include?(a) # a must come AFTER b
      - 1
    elsif rules[a].include?(b) # a must come BEFORE b
      1
    else # don't care, leave it alone
      0
    end
  end

  def valid?(pages)
    idx = pages.each.with_index.with_object(Hash.new(false)) do |(page, i), index|
      index[page] = i
    end

    rules.all? do |pg, before|
      yi = idx[pg]

      if !yi
        next true
      end

      before.all? do |b|
        xi = idx[b]

        if !xi
          next true
        end

        xi < yi
      end
    end
  end
end

# wrapper for rules
ordering = Ordering.new

# middle page from each update
mids = []

## Scanning
scanning_rules = true
script_dir = File.dirname(__FILE__)
File.foreach(File.join(script_dir, "input.txt")) do |line|
  if line == "\n"
    scanning_rules = false
    next
  end

  if scanning_rules
    x, y = line.chomp.split("|").map(&:to_i)
    ordering.rules[y] << x
  end

  pages = line.chomp.split(",").map(&:to_i)

  # we only care about invalid in pt 2
  if ordering.valid?(pages)
    next
  end

  pages.sort! do |a, b|
    ordering.cmp(a, b)
  end

  mi = (pages.length / 2).floor
  mids << pages[mi]
end

total = mids.sum

puts "sum of valid middle pages: #{total}"
