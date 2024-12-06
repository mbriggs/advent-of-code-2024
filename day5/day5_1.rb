#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/5

# ordering rules as an alist of (x . y) where x must be printed before why
rules = []

# list of safe updates
updates = []

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
    pages = line.chomp.split("|").map(&:to_i)
    if pages.length != 2
      raise "invalid rules: #{pages.inspect} from #{line}"
    end

    rules << pages
    next
  end

  pages = line.chomp.split(",").map(&:to_i)
  idx = pages.each.with_index.with_object(Hash.new(false)) do |(page, i), index|
    index[page] = i
  end

  correct = rules.all? do |x, y|
    xi = idx[x]
    yi = idx[y]

    # page in rule doesn't exist, rule not applicable
    if !xi || !yi
      next true
    end

    # x must be before y
    xi < yi
  end

  if correct
    updates << pages
    mi = (pages.length / 2).floor
    mids << pages[mi]
  end
end

total = mids.sum

puts "sum of valid middle pages: #{total}"
