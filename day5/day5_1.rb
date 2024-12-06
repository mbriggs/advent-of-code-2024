#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/5

# ordering rules as an alist of (x . y) where x must be printed before why
rules = []

# middle page from each update
mids = []

## Scanning
# all rules come first, followed by a blank line, followed by groups of pages
scanning_rules = true

script_dir = File.dirname(__FILE__)
File.foreach(File.join(script_dir, "input.txt")) do |line|
  # detect the mode switch
  if line == "\n"
    scanning_rules = false
    next
  end

  # we are currently scanning rules
  if scanning_rules
    pages = line
            .chomp
            .split("|")
            .map(&:to_i)

    if pages.length != 2
      raise "invalid rules: #{pages.inspect} from #{line}"
    end

    rules << pages
    next
  end

  # we are currently scanning pages
  pages = line
          .chomp
          .split(",")
          .map(&:to_i)

  # each page
  # - with the current array index (i)
  # - always yielding an object (index)
  # - Object (index) is a hash which returns false when attempting to access a
  #   missing key
  idx = pages.each.with_index.with_object(Hash.new(false)) do |(page, i), index|
    index[page] = i
  end

  # check that all valid rules pass for the page order to be correct
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
    # finding the mid index (floor because arrays are 0 based)
    mi = (pages.length / 2).floor

    # add the mid page to our list
    mids << pages[mi]
  end
end

total = mids.sum

puts "sum of valid middle pages: #{total}"
