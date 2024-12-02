#!/usr/bin/env ruby
# https://adventofcode.com/2024/day/2

safe_reports = []

def check_levels(levels)
  report_inc = levels[0] < levels[1]

  safe = true

  levels.each_cons(2) do |a,b|
    amount_correct = (a - b).abs.between?(1, 3)

    levels_inc = a < b
    variance_correct = (report_inc && levels_inc) || (!report_inc && !levels_inc)

    if !(amount_correct && variance_correct)
      safe = false
      break
    end
  end

  safe
end

File.foreach("day2_data.txt") do |line|
  levels = line.split.map(&:to_i)

  if levels.length < 2
    raise "not enough levels in report #{line.inspect}"
  end

  result = check_levels(levels)

  if result
    safe_reports << levels
    next
  end

  levels.each_index do |damp_idx|
    dampened = levels.reject.with_index { |_, i| i == damp_idx }
    result = check_levels(dampened)

    if result
      safe_reports << dampened
      break
    end
  end
end

puts "safe reports: #{safe_reports.length}"
